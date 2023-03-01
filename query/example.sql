create table foo
(
    id        Int64,
    birthdate Date,
    name      String
) Engine MergeTree
      partition by toYYYYMM(birthdate) order by id;

insert into foo
select number, today(), 'Dimas'
from numbers(1e8);
insert into foo
select number, today() - 60, 'Purwadi'
from numbers(1e8);

select count() from foo;

create table foo_replicated as foo
    Engine ReplicatedMergeTree('/clickhouse/{cluster}/tables/{database}/{table}/{shard}','{replica}')
        partition by toYYYYMM(birthdate) order by id;

select count()
from foo_replicated;
