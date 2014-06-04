!db2level ;   -- echo current db2 level
!db2set -r ;  -- reset all db2 registers

!db2set DB2_ROCM_DISABLE_FS_CHECK=TRUE;     -- set db2 register values
!db2set DB2_USE_FAST_SCATTERED_IO=OFF;
!db2set DB2_SYSTEM_RAM=1GB;

!db2set -all;     --echo all db2s regsiter values

!db2stop  ;
!db2start ;
create database ldrng_db ;
connect to ldrng_db ;

create long tablespace lng1 managed by database using (file 'tmp/lng1' 1000);
create tablespace reg1 managed by database using (file 'tmp/reg1' 10000);
create tablespace reg2 managed by database using (file 'tmp/reg2' 10000);
create tablespace inx1 managed by database using (file 'tmp/inx1' 30000);

create table TABLE130_9 ( a int , b double not null unique, c varchar(10) not null, d LONG VARCHAR) long in lng1 distribute by(b) organize by
dimensions(a,c) partition by range (a NULLS FIRST,b NULLS LAST) (part p0 starting (MINVALUE,MINVALUE) ending (9,MAXVALUE) in reg1, part p1 starting (10,0) ending (190000,MAXVALUE) in reg1, part p2 starting (200000,0) ending (500000,100000) in reg2);


create index indx1 on TABLE130_9 (a) not partitioned;
insert into TABLE130_9 values (1,2,'aa',NULL);

runstats on table TABLE130_9 with distribution and indexes all set profile only;

load from ldrng130_9.asc of ASC MODIFIED BY reclen= 1047 method L( 1 11, 13 34, 36 45, 47 1046) NULL INDICATORS ( 12, 35, 46, 1047) replace into TABLE130_9 statistics use profile;

select npages from sysstat.tables where tabname='TABLE130_9';

terminate;
