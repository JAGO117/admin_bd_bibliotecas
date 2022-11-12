--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 04/01/2021
--@Descripción: Creación del Spfile, ejecuta ususario ordinario

connect sys/hola1234* as sysdba
startup nomount
create spfile from pfile;
!ls $ORACLE_HOME/dbs/spfilegotoproy.ora