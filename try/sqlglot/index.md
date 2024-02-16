---
x: SQLGlot
title: Try SQLGlot in Y minutes
image: /try/cover.png
lastmod: 2024-01-07
license: MIT
contributors:
    - ["Toby Mao", "https://tobymao.com"]
---

[SQLGlot](https://sqlglot.com/) is a no-dependency SQL parser, transpiler, optimizer, and engine. It can be used to format SQL or translate between 20 different dialects like DuckDB, Presto / Trino, Spark / Databricks, Snowflake, and BigQuery.

It aims to read a wide variety of SQL inputs and output syntactically and semantically correct SQL in the targeted dialects.

See the examples below to get started with SQLGlot:

[Formatting and Transpiling](#formatting-and-transpiling) •
[Metadata](#metadata) •
[Parser Errors](#parser-errors) •
[Unsupported Errors](#unsupported-errors) •
[Build and Modify SQL](#build-and-modify-sql) •
[SQL Optimizer](#sql-optimizer) •
[AST Introspection and Diff](#ast-introspection-and-diff) •
[Custom Dialects](#custom-dialects) •
[SQL Execution](#sql-execution) •

## Formatting and Transpiling

Easily translate from one dialect to another. For example, date/time functions vary between dialects and can be hard to deal with:

```python
import sqlglot

sql = sqlglot.transpile(
    "SELECT EPOCH_MS(1618088028295)",
    read="duckdb", write="hive"
)[0]
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
SELECT FROM_UNIXTIME(1618088028295, 'millis')
```

SQLGlot can even translate custom time formats:

```python
sql = sqlglot.transpile(
    "SELECT STRFTIME(x, '%y-%-m-%S')",
    read="duckdb", write="hive"
)[0]
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
SELECT DATE_FORMAT(x, 'yy-M-ss')
```

As another example, let's suppose that we want to read in a SQL query that contains a CTE and a cast to `REAL`, and then transpile it to Spark, which uses backticks for identifiers and `FLOAT` instead of `REAL`:

```python
sql = """
WITH baz AS (
  SELECT a, c FROM foo WHERE a = 1
)
SELECT
  f.a, b.b, baz.c,
  CAST("b"."a" AS REAL) d
FROM foo f
  JOIN bar b ON f.a = b.a
  LEFT JOIN baz ON f.a = baz.a
"""

sql = sqlglot.transpile(sql, write="spark", identify=True, pretty=True)[0]
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
WITH `baz` AS (
  SELECT
    `a`,
    `c`
  FROM `foo`
  WHERE
    `a` = 1
)
SELECT
  `f`.`a`,
  `b`.`b`,
  `baz`.`c`,
  CAST(`b`.`a` AS FLOAT) AS `d`
FROM `foo` AS `f`
JOIN `bar` AS `b`
  ON `f`.`a` = `b`.`a`
LEFT JOIN `baz`
  ON `f`.`a` = `baz`.`a`
```

Comments are also preserved on a best-effort basis when transpiling SQL code:

```python
sql = """
/* multi
   line
   comment
*/
SELECT
  tbl.cola /* comment 1 */ + tbl.colb /* comment 2 */,
  CAST(x AS INT), # comment 3
  y               -- comment 4
FROM
  bar /* comment 5 */,
  tbl #          comment 6
"""

sql = sqlglot.transpile(sql, read="mysql", pretty=True)[0]
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
/* multi

   line

   comment

*/
SELECT
  tbl.cola /* comment 1 */ + tbl.colb /* comment 2 */,
  CAST(x AS SIGNED), /* comment 3 */
  y /* comment 4 */
FROM bar /* comment 5 */, tbl /*          comment 6 */
```

## Metadata

You can explore SQL with expression helpers to do things like find columns and tables:

```python
from sqlglot import parse_one, exp

# print all column references (a and b)
for column in parse_one("SELECT a, b + 1 AS c FROM d").find_all(exp.Column):
    print(column.alias_or_name)

# find all projections in select statements (a and c)
for select in parse_one("SELECT a, b + 1 AS c FROM d").find_all(exp.Select):
    for projection in select.expressions:
        print(projection.alias_or_name)

# find all tables (x, y, z)
for table in parse_one("SELECT * FROM x JOIN y JOIN z").find_all(exp.Table):
    print(table.name)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
a
b
a
c
x
y
z
```

Read the [AST primer](https://github.com/tobymao/sqlglot/blob/main/posts/ast_primer.md) to learn more about SQLGlot's internals.

## Parser Errors

When the parser detects an error in the syntax, it raises a `ParseError`:

```python
sqlglot.transpile("SELECT foo( FROM bar")
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
Traceback (most recent call last):
  File "/sandbox/main.py", line 3, in <module>
    sqlglot.transpile("SELECT foo( FROM bar")
```

Structured syntax errors are accessible for programmatic use:

```python
import pprint

try:
    sqlglot.transpile("SELECT foo( FROM bar")
except sqlglot.errors.ParseError as e:
    pprint.pprint(e.errors)
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
[{'col': 20,
  'description': 'Expecting )',
  'end_context': '',
  'highlight': 'bar',
  'into_expression': None,
  'line': 1,
  'start_context': 'SELECT foo( FROM '}]
```

## Unsupported Errors

Presto `APPROX_DISTINCT` supports the accuracy argument which is not supported in Hive:

```python
sqlglot.transpile(
    "SELECT APPROX_DISTINCT(a, 0.1) FROM foo",
    read="presto", write="hive"
)
```

<codapi-snippet sandbox="sqlglot" editor="basic" template="main.py" output>
</codapi-snippet>

```
APPROX_COUNT_DISTINCT does not support accuracy
```

## Build and Modify SQL

SQLGlot supports incrementally building sql expressions:

```python
from sqlglot import select, condition

where = condition("x=1").and_("y=1")
sql = select("*").from_("y").where(where).sql()
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
SELECT * FROM y WHERE x = 1 AND y = 1
```

You can also modify a parsed tree:

```python
from sqlglot import parse_one

sql = parse_one("SELECT x FROM y").from_("z").sql()
print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
SELECT x FROM z
```

There is also a way to recursively transform the parsed tree by applying a mapping function to each tree node:

```python
from sqlglot import exp, parse_one

expression_tree = parse_one("SELECT a FROM x")

def transformer(node):
    if isinstance(node, exp.Column) and node.name == "a":
        return parse_one("FUN(a)")
    return node

transformed_tree = expression_tree.transform(transformer)
sql = transformed_tree.sql()

print(sql)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
SELECT FUN(a) FROM x
```

## SQL Optimizer

SQLGlot can rewrite queries into an "optimized" form. It performs a variety of [techniques](https://github.com/tobymao/sqlglot/blob/main/sqlglot/optimizer/optimizer.py) to create a new canonical AST. This AST can be used to standardize queries or provide the foundations for implementing an actual engine. For example:

```python
from sqlglot import parse_one
from sqlglot.optimizer import optimize

print(
    optimize(
        parse_one("""
            SELECT A OR (B OR (C AND D))
            FROM x
            WHERE Z = date '2021-01-01' + INTERVAL '1' month OR 1 = 0
        """),
        schema={"x": {"A": "INT", "B": "INT", "C": "INT", "D": "INT", "Z": "STRING"}}
    ).sql(pretty=True)
)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
SELECT
  (
    "x"."a" <> 0 OR "x"."b" <> 0 OR "x"."c" <> 0
  )
  AND (
    "x"."a" <> 0 OR "x"."b" <> 0 OR "x"."d" <> 0
  ) AS "_col_0"
FROM "x" AS "x"
WHERE
  CAST("x"."z" AS DATE) = CAST('2021-01-01' AS DATE) + INTERVAL '1' MONTH
```

## AST Introspection and Diff

You can see the AST version of the sql by calling `repr`:

```python
from sqlglot import parse_one

print(repr(parse_one("SELECT a + 1 AS z")))
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
Select(
  expressions=[
    Alias(
      this=Add(
        this=Column(
          this=Identifier(this=a, quoted=False)),
        expression=Literal(this=1, is_string=False)),
      alias=Identifier(this=z, quoted=False))])
```

SQLGlot can calculate the difference between two expressions and output changes in a form of a sequence of actions needed to transform a source expression into a target one:

```python
from sqlglot import diff, parse_one

sqldiff = diff(
    parse_one("SELECT a + b, c, d"),
    parse_one("SELECT c, a - b, d")
)
print(sqldiff)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
[Remove(expression=Add(
  this=Column(
    this=Identifier(this=a, quoted=False)),
  expression=Column(
    this=Identifier(this=b, quoted=False)))), Insert(expression=Sub(
  this=Column(
    this=Identifier(this=a, quoted=False)),
  expression=Column(
    this=Identifier(this=b, quoted=False)))), Keep(source=Identifier(this=d, quoted=False), target=Identifier(this=d, quoted=False)), Keep(source=Column(
  this=Identifier(this=c, quoted=False)), target=Column(
  this=Identifier(this=c, quoted=False))), Keep(source=Select(
  expressions=[
    Add(
      this=Column(
        this=Identifier(this=a, quoted=False)),
      expression=Column(
        this=Identifier(this=b, quoted=False))),
    Column(
      this=Identifier(this=c, quoted=False)),
    Column(
      this=Identifier(this=d, quoted=False))]), target=Select(
  expressions=[
    Column(
      this=Identifier(this=c, quoted=False)),
    Sub(
      this=Column(
        this=Identifier(this=a, quoted=False)),
      expression=Column(
        this=Identifier(this=b, quoted=False))),
    Column(
      this=Identifier(this=d, quoted=False))])), Keep(source=Column(
  this=Identifier(this=d, quoted=False)), target=Column(
  this=Identifier(this=d, quoted=False))), Keep(source=Identifier(this=c, quoted=False), target=Identifier(this=c, quoted=False)), Keep(source=Identifier(this=b, quoted=False), target=Identifier(this=b, quoted=False)), Keep(source=Identifier(this=a, quoted=False), target=Identifier(this=a, quoted=False)), Keep(source=Column(
  this=Identifier(this=a, quoted=False)), target=Column(
  this=Identifier(this=a, quoted=False))), Keep(source=Column(
  this=Identifier(this=b, quoted=False)), target=Column(
  this=Identifier(this=b, quoted=False)))]
```

See also: [Semantic Diff for SQL](https://github.com/tobymao/sqlglot/blob/main/posts/sql_diff.md)

## Custom Dialects

[Dialects](https://github.com/tobymao/sqlglot/tree/main/sqlglot/dialects) can be added by subclassing `Dialect`:

```python
from sqlglot import exp
from sqlglot.dialects.dialect import Dialect
from sqlglot.generator import Generator
from sqlglot.tokens import Tokenizer, TokenType

class Custom(Dialect):
    class Tokenizer(Tokenizer):
        QUOTES = ["'", '"']
        IDENTIFIERS = ["`"]

        KEYWORDS = {
            **Tokenizer.KEYWORDS,
            "INT64": TokenType.BIGINT,
            "FLOAT64": TokenType.DOUBLE,
        }

    class Generator(Generator):
        TRANSFORMS = {exp.Array: lambda self, e: f"[{self.expressions(e)}]"}

        TYPE_MAPPING = {
            exp.DataType.Type.TINYINT: "INT64",
            exp.DataType.Type.SMALLINT: "INT64",
            exp.DataType.Type.INT: "INT64",
            exp.DataType.Type.BIGINT: "INT64",
            exp.DataType.Type.DECIMAL: "NUMERIC",
            exp.DataType.Type.FLOAT: "FLOAT64",
            exp.DataType.Type.DOUBLE: "FLOAT64",
            exp.DataType.Type.BOOLEAN: "BOOL",
            exp.DataType.Type.TEXT: "STRING",
        }

print(Dialect["custom"])
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
<class '__main__.Custom'>
```

## SQL Execution

One can even interpret SQL queries using SQLGlot, where the tables are represented as Python dictionaries. Although the engine is not very fast (it's not supposed to be) and is in a relatively early stage of development, it can be useful for unit testing and running SQL natively across Python objects. Additionally, the foundation can be easily integrated with fast compute kernels (arrow, pandas).

Below is an example showcasing the execution of a SELECT expression that involves aggregations and JOINs:

```python
from sqlglot.executor import execute

tables = {
    "sushi": [
        {"id": 1, "price": 1.0},
        {"id": 2, "price": 2.0},
        {"id": 3, "price": 3.0},
    ],
    "order_items": [
        {"sushi_id": 1, "order_id": 1},
        {"sushi_id": 1, "order_id": 1},
        {"sushi_id": 2, "order_id": 1},
        {"sushi_id": 3, "order_id": 2},
    ],
    "orders": [
        {"id": 1, "user_id": 1},
        {"id": 2, "user_id": 2},
    ],
}

res = execute(
    """
    SELECT
      o.user_id,
      SUM(s.price) AS price
    FROM orders o
    JOIN order_items i
      ON o.id = i.order_id
    JOIN sushi s
      ON i.sushi_id = s.id
    GROUP BY o.user_id
    """,
    tables=tables
)

print(res)
```

<codapi-snippet sandbox="sqlglot" editor="basic" output>
</codapi-snippet>

```
user_id price
      1   4.0
      2   3.0
```
