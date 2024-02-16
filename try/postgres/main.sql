\pset border 2
\pset linestyle unicode

create table weather (
  city    varchar(80),
  temp_lo integer,  -- minimum temperature on a day
  temp_hi integer,  -- maximum temperature on a day
  prcp    real,     -- precipitation
  date    date
);

insert into weather (city, temp_lo, temp_hi, prcp, date)
values
('San Francisco', 46, 50, 0.25, '1994-11-27'),
('San Francisco', 43, 57, 0.0, '1994-11-29'),
('Hayward', 37, 54, null, '1994-11-29');

create table cities (
  name      varchar(80),
  location  point
);

insert into cities
values ('San Francisco', '(-194.0, 53.0)');

##CODE##
