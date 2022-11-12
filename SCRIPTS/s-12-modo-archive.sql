--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 08/01/2021
--@Descripción: Habilitacion del modo archive

Prompt Conectando como sys
connect sys/system3 as sysdba 

--Creamos respaldo de spfile
create pfile from spfile;

shutdown immediate
startup

Prompt Configurando parametros necesarios

alter system set log_archive_max_processes=5 scope=spfile;
alter system set log_archive_format='arch_gotoproy_%t_%s_%r.arc' scope=spfile;
alter system set log_archive_trace=12 scope=spfile;
alter system set log_archive_dest_1='LOCATION=/u01/app/oracle/oradata/GOTOPROY/archivelogs/GOTOPROY/disk_a MANDATORY' scope=spfile;
alter system set log_archive_dest_2='LOCATION=/u01/app/oracle/oradata/GOTOPROY/fast-reco-area' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=spfile;

--se detiene la instancia de forma ordenada
shutdown immediate

--se inicia la instancia en modo mount
startup mount

Prompt Activamos Modo Archivelog 
alter database archivelog;
alter database open;

Prompt Verificamos Modo Archivelog
archive log list