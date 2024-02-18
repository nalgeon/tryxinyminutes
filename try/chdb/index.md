---
x: chDB
title: Try chDB in Y minutes
image: /try/cover.png
lastmod: 2023-12-11
canonical: https://antonz.org/trying-chdb/
original: https://antonz.org/trying-chdb/
license: CC-BY-SA-4.0
contributors:
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[chDB](https://github.com/chdb-io/chdb) is an embeddable, in-process SQL OLAP engine powered by ClickHouse. It's as if SQLite and ClickHouse had an offspring (no offence to either party). chDB takes up ≈100mb of disk space, runs on smaller machines (even on a 64mb RAM container), and provides language bindings for Python, Node.js, Go, Rust and C/C++.

[Using chDB](#using-chdb) ·
[SQL dialect](#sql-dialect) ·
[Reading data](#reading-data) ·
[Writing data](#writing-data) ·
[User-defined functions](#user-defined-functions) ·
[Python DB API](#python-database-api) ·
[Further reading](#further-reading)

## Using chDB

It's as simple as `pip install chdb` and then:

```python
import chdb

res = chdb.query("select 42")
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic">
</codapi-snippet>

Using a database engine to select the number `42` is probably not very exciting, but bear with me.

## SQL dialect

chDB is a wrapper around ClickHouse, so it supports exactly the same [SQL syntax](https://clickhouse.com/docs/en/sql-reference/syntax), including joins, CTEs, set operations, aggregations and window functions.

For example, let's create a sampled table of 10000 random numbers and calculate the mean and 95th percentile:

```python
from chdb.session import Session

db = Session()
db.query("create database db")
db.query("use db")

db.query("""
create table data (id UInt32, x UInt32)
engine MergeTree order by id sample by id
as
select number+1 as id, randUniform(1, 100) as x
from numbers(10000);
""")

query_sql = """
select
  avg(x) as "avg",
  round(quantile(0.95)(x), 2) as p95
from data
sample 0.1;
"""

res = db.query(query_sql, "PrettyCompactNoEscapes")
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic">
</codapi-snippet>

Note a couple of things here:

-   `Session` provides a stateful database connection (the data is stored in the temporary folder and discarded when the connection is closed).
-   The second argument to the `query` method specifies the output format. There are many [supported formats](https://doc.chdb.io/#/formats) such as `CSV`, `SQLInsert`, `JSON` and `XML` (try changing the format in the above example and re-running the code). The default one is `CSV`.

## Reading data

As with output formats, chDB supports any input format supported by ClickHouse.

For example, we can read a dataset from CSV:

```python
query_sql = "select * from 'employees.csv'"
res = chdb.query(query_sql, "PrettyCompactNoEscapes")
print(
    f"{res.rows_read()} rows | "
    f"{res.bytes_read()} bytes | "
    f"{res.elapsed()} seconds"
)
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py" files="employees.csv">
</codapi-snippet>

Or work with an external dataset as if it were a database table:

```python
query_sql = """
select distinct city
from 'employees.csv'
"""

res = chdb.query(query_sql, "CSV")
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py" files="employees.csv">
</codapi-snippet>

We can even query Pandas dataframes as if they were tables:

```python
import chdb.dataframe as cdf
import pandas as pd

employees = pd.read_csv("employees.csv")
departments = pd.read_csv("departments.csv")

query_sql = """
select
  emp_id, first_name,
  dep.name as dep_name,
  salary
from __emp__ as emp
    join __dep__ as dep using(dep_id)
order by salary desc;
"""

res = cdf.query(sql=query_sql, emp=employees, dep=departments)
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" files="employees.csv departments.csv">
</codapi-snippet>

## Writing data

The easiest way to export data is to use the output format (the second parameter in the `query` method), and then write the data to disk:

```python
from pathlib import Path

query_sql = "select * from 'employees.csv'"
res = chdb.query(query_sql, "Parquet")

# export to Parquet
path = Path("/tmp/employees.parquet")
path.write_bytes(res.bytes())

# import from Parquet
query_sql = "select * from '/tmp/employees.parquet' limit 5"
res = chdb.query(query_sql, "PrettyCompactNoEscapes")
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py" files="employees.csv">
</codapi-snippet>

We can also easily convert the chDB result object into a PyArrow table:

```python
query_sql = "select * from 'employees.csv'"
res = chdb.query(query_sql, "Arrow")

table = chdb.to_arrowTable(res)
print(table.schema)
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py" files="employees.csv">
</codapi-snippet>

Or Pandas dataframe:

```python
query_sql = "select * from 'employees.csv'"
res = chdb.query(query_sql, "Arrow")

frame = chdb.to_df(res)
frame.info()
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py" files="employees.csv">
</codapi-snippet>

To persist a chDB session to a specific folder on disk, use the `path` constructor parameter. This way you can restore the session later:

```python
from chdb.session import Session

# create a persistent session
db = Session(path="/tmp/employees")

# create a database and a table
db.query("create database db")
db.query("""
create table db.employees (
  emp_id UInt32 primary key,
  first_name String, last_name String,
  birth_dt Date, hire_dt Date,
  dep_id String, city String,
  salary UInt32,
) engine MergeTree;
""")

# load data into the table
db.query("""
insert into db.employees
select * from 'employees.csv'
""")

# ...
# restore the session later
db = Session(path="/tmp/employees")

# query the data
res = db.query("select count(*) from db.employees")
print(res, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" files="employees.csv">
</codapi-snippet>

## User-defined functions

We can define a function in Python and use it in chDB SQL queries.

Here is a `split_part` function that splits a string on the given separator and returns the resulting field with the given index (counting from one):

```python
from chdb.udf import chdb_udf

@chdb_udf()
def split_part(s, sep, idx):
    idx = int(idx)-1
    return s.split(sep)[idx]


second = chdb.query("select split_part('a;b;c', ';', 2)")
print(second, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py">
</codapi-snippet>

And here is a `sumn` function that calculates a sum from 1 to N:

```python
from chdb.udf import chdb_udf

@chdb_udf(return_type="Int32")
def sumn(n):
    n = int(n)
    return n*(n+1)//2


sum20 = chdb.query("select sumn(20)")
print(sum20, end="")
```

<codapi-snippet sandbox="chdb-python" editor="basic" template="main.py">
</codapi-snippet>

Currently chDB only supports scalar functions that take strings as parameters. If the function returns a type other than string, we should pass it as `return_type` to the `chdb_udf` decorator.

## Python Database API

The chDB Python package adheres to the Python DB API ([PEP 249](https://peps.python.org/pep-0249/)), so you can use it just like you'd use stdlib's `sqlite3` module:

```python
from contextlib import closing
from chdb import dbapi

print(f"chdb version: {dbapi.get_client_info()}")

with closing(dbapi.connect()) as conn:
    with closing(conn.cursor()) as cur:
        cur.execute("select version()")
        print("description:", cur.description)
        print("data:", cur.fetchone())
```

<codapi-snippet sandbox="chdb-python" editor="basic">
</codapi-snippet>

## Further reading

See the chDB [documentation](https://doc.chdb.io/) for details on using chDB with other programming languages, sample Jupyter notebooks, and SQL reference.
