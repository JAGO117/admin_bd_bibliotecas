--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 08/01/2021
--@Descripción: Mueve una grupo de online redo log a la FRA


alter database add logfile size 50m blocksize 512;

alter database
add logfile member '/u04/app/oracle/oradata/GOTOPROY/redo04b.log' to group 4;
alter database
add logfile member '/u05/app/oracle/oradata/GOTOPROY/redo04c.log' to group 4;
