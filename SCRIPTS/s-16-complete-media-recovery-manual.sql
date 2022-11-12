--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 10/01/2021
--@Descripción: Proceso de complete media recovery manual

--SQL
shutdown immediate;

--EJECUTAR EN $ORACLE_BASE/oradata/GOTOPROY para mover data file
mv recursos01.dbf recursos01.dbf.db

-- INTENTAR INICIAR (MARCARA ERROR)
startup

alter database datafile 8 offline;

-- EN RMAN
restore datafile 8;
recover datafile 8;

-- EN SQLPLUS
alter database datafile 8 online;