---
x: PostgreSQL
title: Try PostgreSQL in Y minutes
image: /try/cover.png
lastmod: 2024-02-15
original: https://www.postgresql.org/docs/current/tutorial-sql.html
license: CC-BY-SA-4.0
contributors:
    - ["PostgreSQL Team", "https://www.postgresql.org/"]
    - ["Anton Zhiyanov", "https://antonz.org/"]
---

This is an overview of SQL as implemented in PostgreSQL.

Make sure that you have created a database, and can connect to it using the shell (`psql`) or other tools. If you haven't, see the [Getting Started](https://www.postgresql.org/docs/current/tutorial-start.html) guide first.

[Concepts](#concepts) ·
[Creating tables](#creating-a-new-table) ·
[Populating with data](#populating-a-table-with-rows) ·
[Querying](#querying-a-table) ·
[Joins](#joins-between-tables) ·
[Aggregates](#aggregate-functions) ·
[Updates](#updates) ·
[Deletions](#deletions) ·
[Further reading](#further-reading)

<div class="tryx__panel">
<p>✨ <strong>This guide needs some love</strong></p>
<p>The guide only covers the basics of SQL. It would be great to add some PostgreSQL specifics. If you'd like to help — please <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/postgres/index.md">contribute</a>!</p>
</div>

## Concepts

PostgreSQL is a relational database management system (RDBMS). That means it is a system for managing data stored in _relations_. A relation is essentially a mathematical term for a _table_.

Each table is a named collection of _rows_. Each row of a given table has the same set of named _columns_, and each column is of a specific _data type_. While columns have a fixed order in each row, SQL does not guarantee the order of the rows within the table in any way (although they can be explicitly sorted for display).

Tables themselves are stored inside _schemas_, and a collection of schemas constitutes the entire _database_ that you can access.

## Creating a new table

Create a new table by specifying the table name, along with all column names and their types:

```sql
create table weather (
  city    varchar(80),
  temp_lo integer,  -- minimum temperature on a day
  temp_hi integer,  -- maximum temperature on a day
  prcp    real,     -- precipitation
  date    date
);
```

<codapi-snippet id="s-weather" sandbox="postgres" editor="basic" output-mode="hidden">
</codapi-snippet>

You can type this into the shell with the line breaks. The command is not terminated until the semicolon.

White space (i.e., spaces, tabs, and newlines) can be used freely in SQL commands. This means you can type the command aligned differently than above, or even all on one line.

Two dashes (`--`) introduce comments. Whatever follows is ignored until the end of the line. SQL is case-insensitive for keywords and identifiers, except when identifiers are double-quoted to preserve the case (not shown above).

In the SQL command, we first specify the type of command we want to execute: `create table`. Then the command parameters: table name (`weather`), followed by column names and column types.

-   `varchar(80)` specifies that the column can store arbitrary character strings up to 80 characters long.
-   `integer` columns store integer numbers (i.e., whole numbers without a decimal point).
-   `real` columns store single precision floating-point numbers (i.e., numbers with a decimal point).
-   `date` columns store dates (i.e., a combination of year, month, day). A `date` value stores only the specific day, not the time associated with that day.

PostgreSQL supports the standard SQL types `integer`, `smallint`, `real`, `double precision`, `char(n)`, `varchar(n)`, `date`, `time`, `timestamp` and `interval`, as well as common types and a rich set of geometric types.

PostgreSQL can be customized with an arbitrary number of user-defined data types. Consequently, type names are not keywords in the syntax, except where required to support special cases in the SQL standard.

The second example stores cities and their associated geographic location:

```sql
create table cities (
  name      varchar(80),
  location  point
);
```

<codapi-snippet id="s-cities" sandbox="postgres" editor="basic" output-mode="hidden">
</codapi-snippet>

The `point` type is an example of a PostgreSQL-specific data type.

If you don't need a table anymore or want to recreate it differently, you can remove it with the `drop table` command:

```sql
drop table cities;
```

<codapi-snippet sandbox="postgres" editor="basic" depends-on="s-cities" output-mode="hidden">
</codapi-snippet>

## Populating a table with rows

Use `insert` statement to populate a table with rows:

```sql
insert into weather
values ('San Francisco', 46, 50, 0.25, '1994-11-27');
```

<codapi-snippet sandbox="postgres" editor="basic" depends-on="s-weather s-cities" output-mode="hidden">
</codapi-snippet>

All data types use fairly obvious input formats. Constants that are not numeric values (e.g., text and dates) must be enclosed in single quotes (`''`), as in the example. Date values are usually formatted as `'YYYY-MM-DD'` (although the `date` type is actually quite flexible in what it accepts).

The `point` type requires a coordinate pair as input:

```sql
insert into cities
values ('San Francisco', '(-194.0, 53.0)');
```

<codapi-snippet sandbox="postgres" editor="basic" depends-on="s-weather s-cities" output-mode="hidden">
</codapi-snippet>

The syntax used so far requires you to remember the order of the columns. An alternative syntax allows you to list the columns explicitly:

```sql
insert into weather (city, temp_lo, temp_hi, prcp, date)
values ('San Francisco', 43, 57, 0.0, '1994-11-29');
```

<codapi-snippet sandbox="postgres" editor="basic" depends-on="s-weather s-cities" output-mode="hidden">
</codapi-snippet>

You can list the columns in a different order if you wish or even omit some columns, e.g., if the precipitation is unknown:

```sql
insert into weather (date, city, temp_hi, temp_lo)
values ('1994-11-29', 'Hayward', 54, 37);
```

<codapi-snippet sandbox="postgres" editor="basic" depends-on="s-weather s-cities" output-mode="hidden">
</codapi-snippet>

Many developers consider explicitly listing the columns better style than relying on the order implicitly.

You can also use `copy` to load large amounts of data from CSV files. This is usually faster because the `copy` command is optimized for this use case, but allows less flexibility than `insert`. An example with [`weather.csv`](weather.csv) would be:

```sql
copy weather from 'weather.csv';
```

where the file name for the source file must be available on the machine running the backend process, not the client (since the backend process reads the file directly). You can read more about the `copy` command in the [COPY](https://www.postgresql.org/docs/current/sql-copy.html) section.

## Querying a table

To retrieve data from a table, the table is _queried_. This is done using an SQL `select` statement. The statement is divided into a select list (the part that lists the columns to be returned), a table list (the part that lists the tables from which to retrieve the data), and an optional qualification (the part that specifies any restrictions).

Retrieve all the rows of the `weather` table:

```sql
select *
from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │
│ Hayward       │      37 │      54 │      │ 1994-11-29 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

Here `*` is a shorthand for "all columns". So the same result would be achieved with:

```sql
select city, temp_lo, temp_hi, prcp, date
from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │
│ Hayward       │      37 │      54 │      │ 1994-11-29 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

You can write expressions, not just simple column references, in the select list. For example, you can do:

```sql
select city, (temp_hi+temp_lo)/2 as temp_avg, date
from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬──────────┬────────────┐
│     city      │ temp_avg │    date    │
├───────────────┼──────────┼────────────┤
│ San Francisco │       48 │ 1994-11-27 │
│ San Francisco │       50 │ 1994-11-29 │
│ Hayward       │       45 │ 1994-11-29 │
└───────────────┴──────────┴────────────┘
(3 rows)
```

Notice how the `as` clause is used to relabel the output column. (The `as` clause is optional.)

A query can be "qualified" by adding a `where` clause that specifies which rows are wanted. The `where` clause contains a Boolean (truth value) expression, and only rows for which the Boolean expression is true are returned. The usual Boolean operators (`and`, `or`, and `not`) are allowed in the qualification.

Retrieve the weather of San Francisco on rainy days:

```sql
select *
from weather
where city = 'San Francisco' and prcp > 0.0;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(1 row)
```

Return the results of a query in sorted order:

```sql
select *
from weather
order by city;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ Hayward       │      37 │      54 │      │ 1994-11-29 │
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

In this example, the sort order isn't fully specified, so you might get the San Francisco rows in either order. To get a fixed order, add another column to sort the rows with equal `city` values:

```sql
select *
from weather
order by city, temp_lo;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ Hayward       │      37 │      54 │      │ 1994-11-29 │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

Remove the duplicate rows from the result:

```sql
select distinct city
from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┐
│     city      │
├───────────────┤
│ Hayward       │
│ San Francisco │
└───────────────┘
(2 rows)
```

Here again, the result row ordering might vary. You can ensure consistent results by using `distinct` and `order by` together:

```sql
select distinct city
from weather
order by city;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┐
│     city      │
├───────────────┤
│ Hayward       │
│ San Francisco │
└───────────────┘
(2 rows)
```

## Joins between tables

So far, our queries have only accessed one table at a time. Queries can access multiple tables at once, or access the same table in such a way that multiple rows of the table are being processed at the same time.

Queries that access multiple tables (or multiple instances of the same table) at once are called _join_ queries. They combine rows from one table with rows from a second table, using an expression that specifies which rows are to be paired.

For example, to return all the weather records together with the location of the associated city, the database needs to compare the `city` column of each row in the `weather` table with the `name` column of each row in the `cities` table, and select the pairs of rows where these values match.

Here is the query to accomplish this:

```sql
select *
from weather join cities on city = name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │     name      │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ San Francisco │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ San Francisco │ (-194,53) │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────────┴───────────┘
(2 rows)
```

Note two things about the result set:

-   There is no result row for the city of Hayward. This is because there is no matching entry in the `cities` table for Hayward, so the join ignores the unmatched rows in the `weather` table. We will fix this shortly.
-   There are two columns containing the city name. This is correct because the lists of columns from the `weather` and `cities` tables are concatenated. In practice, however, this is undesirable, so you will probably want to list the output columns explicitly rather than using `*`:

```sql
select city, temp_lo, temp_hi, prcp, date, location
from weather join cities on city = name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ (-194,53) │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────┘
(2 rows)
```

Since the columns all had different names, the parser automatically found which table they belong to. If there were duplicate column names in the two tables, you'd have to _qualify_ the column names to show which one you meant, as in:

```sql
select
  weather.city, weather.temp_lo, weather.temp_hi,
  weather.prcp, weather.date, cities.location
from weather join cities on weather.city = cities.name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ (-194,53) │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────┘
(2 rows)
```

It is generally considered good practice to qualify all column names in a join query, so that the query won't fail if a duplicate column name is later added to one of the tables.

Join queries of the kind seen so far can also be written in this alternative form:

```sql
select *
from weather, cities
where city = name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │     name      │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ San Francisco │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ San Francisco │ (-194,53) │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────────┴───────────┘
(2 rows)
```

This syntax predates the `join/on` syntax introduced in SQL-92. The tables are simply listed in the `from` clause, and the comparison expression is added to the `where` clause.

The results from this older implicit syntax and the newer explicit `join/on` syntax are identical. But for a reader of the query, the explicit syntax makes its meaning easier to understand: The join condition is introduced by its own keyword, whereas before the condition was mixed in with other conditions in the `where` clause.

Now we will figure out how to get the Hayward records back in. What we want the query to do is to scan the `weather` table and for each row to find the matching `cities` row(s). If no matching row is found, we want some "empty values" to be substituted for the `cities` table's columns. This kind of query is called an _outer join_. (The joins we have seen so far are _inner joins_.)

Here is the query:

```sql
select *
from weather
left outer join cities on weather.city = cities.name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │     name      │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ San Francisco │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ San Francisco │ (-194,53) │
│ Hayward       │      37 │      54 │      │ 1994-11-29 │               │           │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────────┴───────────┘
(3 rows)
```

This query is called a _left outer join_ because the table on the left of the `join` operator will have each of its rows in the output at least once, while the table on the right will have only those rows that match some row of the left table. When outputting a left-table row for which there is no right-table match, empty (`null`) values are substituted for the right-table columns.

There are also _right outer joins_ and _full outer joins_, but we will not cover them here. See [SQL join flavors](https://antonz.org/sql-join/) for details.

We can also join a table against itself. This is called a _self join_. Suppose we want to find all the weather records that are within the temperature range of other weather records. So we need to compare the `temp_lo` and `temp_hi` columns of each `weather` row to the `temp_lo` and `temp_hi` columns of all other `weather` rows. We can do this with the following query:

```sql
select
  w1.city, w1.temp_lo as low, w1.temp_hi as high,
  w2.city, w2.temp_lo as low, w2.temp_hi as high
from weather w1 join weather w2
  on w1.temp_lo < w2.temp_lo and w1.temp_hi > w2.temp_hi;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────┬──────┬───────────────┬─────┬──────┐
│     city      │ low │ high │     city      │ low │ high │
├───────────────┼─────┼──────┼───────────────┼─────┼──────┤
│ San Francisco │  43 │   57 │ San Francisco │  46 │   50 │
│ Hayward       │  37 │   54 │ San Francisco │  46 │   50 │
└───────────────┴─────┴──────┴───────────────┴─────┴──────┘
(2 rows)
```

Here we have relabeled the `weather` table as `w1` and `w2` to distinguish the left and right side of the join. You can also use these kinds of aliases in other queries to save some typing, e.g.:

```sql
select *
from weather w
join cities c on w.city = c.name;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┬───────────────┬───────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │     name      │ location  │
├───────────────┼─────────┼─────────┼──────┼────────────┼───────────────┼───────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │ San Francisco │ (-194,53) │
│ San Francisco │      43 │      57 │    0 │ 1994-11-29 │ San Francisco │ (-194,53) │
└───────────────┴─────────┴─────────┴──────┴────────────┴───────────────┴───────────┘
(2 rows)
```

You will see this type of abbreviation quite often.

## Aggregate functions

Like most other relational database products, PostgreSQL supports _aggregate functions_. An aggregate function computes a single result from multiple input rows. For example, there are aggregates to compute the `count`, `sum`, `avg` (average), `max` (maximum) and `min` (minimum) over a set of rows.

Find the highest low-temperature reading anywhere:

```sql
select max(temp_lo)
from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌─────┐
│ max │
├─────┤
│  46 │
└─────┘
(1 row)
```

If we wanted to know what city (or cities) that reading occurred in, we might try:

```sql
-- WRONG
select city
from weather
where temp_lo = max(temp_lo);
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
ERROR:  aggregate functions are not allowed in WHERE
LINE 3: where temp_lo = max(temp_lo);
                        ^
```

This will not work because the aggregate `max` cannot be used in the `where` clause. This restriction exists because the `where` clause determines which rows will be included in the aggregate calculation; so obviously it has to be evaluated before aggregate functions are computed.

However, as is often the case, the query can be restated to achieve the desired result, here by using a _subquery_:

```sql
select city
from weather
where temp_lo = (select max(temp_lo) from weather);
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┐
│     city      │
├───────────────┤
│ San Francisco │
└───────────────┘
(1 row)
```

This is OK because the subquery is an independent computation that computes its own aggregate separately from what happens in the outer query.

Aggregates are also very useful in combination with `group by` clauses. For example, we can get the number of readings and the maximum low temperature observed in each city:

```sql
select city, count(*), max(temp_lo)
from weather
group by city;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬───────┬─────┐
│     city      │ count │ max │
├───────────────┼───────┼─────┤
│ Hayward       │     1 │  37 │
│ San Francisco │     2 │  46 │
└───────────────┴───────┴─────┘
(2 rows)
```

which gives us one output row per city. Each aggregate result is computed over the table rows matching that city.

We can filter these grouped rows using `having`:

```sql
select city, count(*), max(temp_lo)
from weather
group by city
having max(temp_lo) < 40;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌─────────┬───────┬─────┐
│  city   │ count │ max │
├─────────┼───────┼─────┤
│ Hayward │     1 │  37 │
└─────────┴───────┴─────┘
(1 row)
```

which gives us the same results, but only for cities where all `temp_lo` values are below 40.

Finally, if we only care about cities whose names begin with "S", we can use the `like` operator:

```sql
select city, count(*), max(temp_lo)
from weather
where city like 'S%'
group by city;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬───────┬─────┐
│     city      │ count │ max │
├───────────────┼───────┼─────┤
│ San Francisco │     2 │  46 │
└───────────────┴───────┴─────┘
(1 row)
```

The fundamental difference between `where` and `having` is this:

-   `where` selects input rows _before_ groups and aggregates are computed (so it controls which rows go into the aggregate computation).
-   `having` selects group rows _after_ groups and aggregates are computed.

Thus, the `where` clause must not contain aggregate functions: it makes no sense to try to use an aggregate to determine which rows will be inputs to the aggregates. On the other hand, the `having` clause always contains aggregate functions. (Strictly speaking, you can write a `having` clause that doesn't use aggregates, but this is rarely useful. The same condition could be used more efficiently at the `where` stage.)

In the previous example, we can apply the city name restriction in `where`, since it needs no aggregate. This is more efficient than adding the restriction to `having`, because we avoid doing the grouping and aggregate calculations for all rows that fail the `where` check.

Another way to select the rows that go into an aggregate computation is to use `filter`, which is a per-aggregate option:

```sql
select
  city,
  count(*) filter (where temp_lo < 45),
  max(temp_lo)
from weather
group by city;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output>
</codapi-snippet>

```
┌───────────────┬───────┬─────┐
│     city      │ count │ max │
├───────────────┼───────┼─────┤
│ Hayward       │     1 │  37 │
│ San Francisco │     1 │  46 │
└───────────────┴───────┴─────┘
(2 rows)
```

`filter` is similar to `where`, except that it only removes rows from the input of the particular aggregate function it is attached to. Here, the `count` aggregate only counts rows with `temp_lo` below 45; but the `max` aggregate is still applied to all rows, so it still finds the reading of 46.

## Updates

To update existing rows, use the `update` command. Suppose you discover the temperature readings are all off by 2 degrees after November 28. You can correct the data as follows:

```sql
update weather
set temp_hi = temp_hi - 2, temp_lo = temp_lo - 2
where date > '1994-11-28';
```

<codapi-snippet id="s-update" sandbox="postgres" editor="basic" template="main.sql" output-mode="hidden">
</codapi-snippet>

Look at the new state of the data:

```sql
select * from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" depends-on="s-update" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
│ San Francisco │      41 │      55 │    0 │ 1994-11-29 │
│ Hayward       │      35 │      52 │      │ 1994-11-29 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

## Deletions

To remove rows from a table, use the `delete` command. Suppose you are no longer interested in the weather of Hayward. Then delete those rows from the table as follows:

```sql
delete from weather
where city = 'Hayward';
```

<codapi-snippet id="s-delete" sandbox="postgres" editor="basic" template="main.sql" output-mode="hidden">
</codapi-snippet>

All Hayward weather records are removed:

```sql
select * from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" depends-on="s-delete" output>
</codapi-snippet>

```
┌───────────────┬─────────┬─────────┬──────┬────────────┐
│     city      │ temp_lo │ temp_hi │ prcp │    date    │
├───────────────┼─────────┼─────────┼──────┼────────────┤
│ San Francisco │      46 │      50 │ 0.25 │ 1994-11-27 │
│ San Francisco │      41 │      55 │    0 │ 1994-11-29 │
│ Hayward       │      35 │      52 │      │ 1994-11-29 │
└───────────────┴─────────┴─────────┴──────┴────────────┘
(3 rows)
```

Beware of `delete` without `where`:

```sql
delete from weather;
```

<codapi-snippet sandbox="postgres" editor="basic" template="main.sql" output-mode="hidden">
</codapi-snippet>

Without a qualification, `delete` will remove all rows from the table, leaving it empty. The system will not ask for confirmation!

## Further reading

For more information about SQL as implemented in PostgreSQL, see the [documentation](https://www.postgresql.org/docs/current/sql.html).
