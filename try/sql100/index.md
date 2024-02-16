---
title: SQL in 100 Queries
image: /try/cover.png
lastmod: 2024-02-15
original: https://gvwilson.github.io/sql-tutorial/
license: CC-BY-NC-4.0
contributors:
    - ["Greg Wilson", "https://github.com/gvwilson"]
---

An Introduction to SQL for Wary Data Scientists.

## 1: Selecting Constant

```sql
select 42;
```

<codapi-snippet sandbox="sql100" command="penguins" editor="basic" output>
</codapi-snippet>

```
42
```

`select` is a keyword. Normally used to select data from table, but if all we want
is a constant value, we don’t need to specify one.

Semi-colon terminator is required.

## 2: Selecting All Values from Table

```sql
select * from little_penguins;
```

<codapi-snippet sandbox="sql100" command="penguins" editor="basic" output>
</codapi-snippet>

```
Gentoo|Biscoe|51.3|14.2|218.0|5300.0|MALE
Adelie|Dream|35.7|18.0|202.0|3550.0|FEMALE
Adelie|Torgersen|36.6|17.8|185.0|3700.0|FEMALE
Chinstrap|Dream|55.8|19.8|207.0|4000.0|MALE
Adelie|Dream|38.1|18.6|190.0|3700.0|FEMALE
Adelie|Dream|36.2|17.3|187.0|3300.0|FEMALE
Adelie|Dream|39.5|17.8|188.0|3300.0|FEMALE
Gentoo|Biscoe|42.6|13.7|213.0|4950.0|FEMALE
Gentoo|Biscoe|52.1|17.0|230.0|5550.0|MALE
Adelie|Torgersen|36.7|18.8|187.0|3800.0|FEMALE
```

Use `*` to mean "all columns" and `from tablename` to specify table.

Output format is not particularly readable, but we'll fix that.

## ☆ Administrative Commands

```sql
.headers on
.mode markdown
select * from little_penguins;
```

<codapi-snippet sandbox="sql100" command="penguins" editor="basic" output>
</codapi-snippet>

```
|  species  |  island   | bill_length_mm | bill_depth_mm | flipper_length_mm | body_mass_g |  sex   |
|-----------|-----------|----------------|---------------|-------------------|-------------|--------|
| Gentoo    | Biscoe    | 51.3           | 14.2          | 218.0             | 5300.0      | MALE   |
| Adelie    | Dream     | 35.7           | 18.0          | 202.0             | 3550.0      | FEMALE |
| Adelie    | Torgersen | 36.6           | 17.8          | 185.0             | 3700.0      | FEMALE |
| Chinstrap | Dream     | 55.8           | 19.8          | 207.0             | 4000.0      | MALE   |
| Adelie    | Dream     | 38.1           | 18.6          | 190.0             | 3700.0      | FEMALE |
| Adelie    | Dream     | 36.2           | 17.3          | 187.0             | 3300.0      | FEMALE |
| Adelie    | Dream     | 39.5           | 17.8          | 188.0             | 3300.0      | FEMALE |
| Gentoo    | Biscoe    | 42.6           | 13.7          | 213.0             | 4950.0      | FEMALE |
| Gentoo    | Biscoe    | 52.1           | 17.0          | 230.0             | 5550.0      | MALE   |
| Adelie    | Torgersen | 36.7           | 18.8          | 187.0             | 3800.0      | FEMALE |
```

SQLite administrative commands start with `.` and aren’t part of the SQL standard. PostgreSQL’s special commands start with `\`.

Use `.help` for a complete list of commands.

From now on I'll use the `.mode box` output mode.

## 3: Specifying Columns

```sql
select
    species,
    island,
    sex
from little_penguins;
```

<codapi-snippet sandbox="sql100" command="penguins" editor="basic" template="box.sql" output>
</codapi-snippet>

```
┌───────────┬───────────┬────────┐
│  species  │  island   │  sex   │
├───────────┼───────────┼────────┤
│ Gentoo    │ Biscoe    │ MALE   │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Torgersen │ FEMALE │
│ Chinstrap │ Dream     │ MALE   │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Dream     │ FEMALE │
│ Adelie    │ Dream     │ FEMALE │
│ Gentoo    │ Biscoe    │ FEMALE │
│ Gentoo    │ Biscoe    │ MALE   │
│ Adelie    │ Torgersen │ FEMALE │
└───────────┴───────────┴────────┘
```

Specify column names separated by commas, in any order. Duplicates are allowed. Line breaks are ~~allowed~~ encouraged for readability.

## 4: Sorting

```sql
select
    species,
    sex,
    island
from little_penguins
order by island asc, sex desc;
```

<codapi-snippet sandbox="sql100" command="penguins" editor="basic" template="box.sql" output>
</codapi-snippet>

```
┌───────────┬────────┬───────────┐
│  species  │  sex   │  island   │
├───────────┼────────┼───────────┤
│ Gentoo    │ MALE   │ Biscoe    │
│ Gentoo    │ MALE   │ Biscoe    │
│ Gentoo    │ FEMALE │ Biscoe    │
│ Chinstrap │ MALE   │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Dream     │
│ Adelie    │ FEMALE │ Torgersen │
│ Adelie    │ FEMALE │ Torgersen │
└───────────┴────────┴───────────┘
```

`order by` must follow `from` (which must follow select). `asc` is ascending, `desc` is descending.
Default is ascending, but please specify.

To be continued...
