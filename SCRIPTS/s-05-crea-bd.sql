--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 04/01/2021
--@Descripción: Creación de la BD, ejecuta ordinario

connect sys/hola1234* as sysdba
startup nomount

whenever sqlerror exit rollback

create database gotoproy
  user sys identified by system3
  user system identified by system3
  logfile group 1 (
    '/u01/app/oracle/oradata/GOTOPROY/redo01a.log',
    '/u04/app/oracle/oradata/GOTOPROY/redo01b.log',
    '/u05/app/oracle/oradata/GOTOPROY/redo01c.log') size 50m blocksize 512,
  group 2 (
    '/u01/app/oracle/oradata/GOTOPROY/redo02a.log',
    '/u04/app/oracle/oradata/GOTOPROY/redo02b.log',
    '/u05/app/oracle/oradata/GOTOPROY/redo02c.log') size 50m blocksize 512,
  group 3 (
    '/u01/app/oracle/oradata/GOTOPROY/redo03a.log',
    '/u04/app/oracle/oradata/GOTOPROY/redo03b.log',
    '/u05/app/oracle/oradata/GOTOPROY/redo03c.log') size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
  datafile '/u01/app/oracle/oradata/GOTOPROY/system01.dbf'
    size 700m reuse autoextend on next 10240k maxsize unlimited
  sysaux datafile '/u01/app/oracle/oradata/GOTOPROY/sysaux01.dbf'
    size 550m reuse autoextend on next 10240k maxsize unlimited
  default tablespace users
    datafile '/u01/app/oracle/oradata/GOTOPROY/users01.dbf'
    size 500m reuse autoextend on maxsize unlimited
  default temporary tablespace tempts1
    tempfile '/u01/app/oracle/oradata/GOTOPROY/temp01.dbf'
    size 20m reuse autoextend on next 640k maxsize unlimited
  undo tablespace undotbs1
    datafile '/u01/app/oracle/oradata/GOTOPROY/undotbs01.dbf'
    size 200m reuse autoextend on next 5120k maxsize unlimited;

alter user sys identified by system3;
alter user system identified by system3;
alter user sysbackup identified by system3;