create table job (
  name varchar(10) not null,
  billable real not null
);

insert into job values
('calibrate', 1.5),
('clean', 0.5);

create table work (
  person varchar(5) not null,
  job varchar(10) not null
);

insert into work values
('mik', 'calibrate'),
('mik', 'clean'),
('mik', 'complain'),
('po', 'clean'),
('po', 'complain'),
('tay', 'complain');

##CODE##
