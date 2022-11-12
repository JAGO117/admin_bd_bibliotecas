--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 08/01/2021
--@Descripción: Habilitacion de la FRA

-- crea respaldo del spfile
create pfile from spfile;

-- se establece tamaño de la fra
alter system set db_recovery_file_dest_size=3G scope=both;

-- se establece la ruta de la fra
alter system set db_recovery_file_dest='/u01/app/oracle/oradata/GOTOPROY/fast-reco-area' scope=both;

-- se establece la política de retención de la fra
alter system set db_flashback_retention_target=1440 scope=both;

alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;

alter database flashback on;