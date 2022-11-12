--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 06/01/2021
--@Descripción: Creación de los tablespaces

--TABLESPACE PARA DATOS BLOB/CLOB DEL MÓDULO USUARIOS_BIBLIOTECAS
create bigfile tablespace usuarios_bibliotecas_blob_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/usuarios_bibliotecas_blob01.dbf'
  size 10m 
autoextend on next 10m maxsize 2g
extent management local autoallocate
segment space management auto;

--TABLESPACE PARA DATOS BLOB/CLOB DEL MÓDULO RECURSOS
create bigfile tablespace recursos_blob_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/recursos_blob01.dbf'
  size 10m 
autoextend on next 10m maxsize 2g
extent management local autoallocate
segment space management auto;

--TABLESPACE PARA EL MODULO USUARIOS_BIBLIOTECAS
create tablespace usuarios_bibliotecas_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/usuarios01.dbf'
  size 100m
  autoextend on next 10m maxsize 300m
extent management local autoallocate
segment space management auto;

--tablespace PARA EL MÓDULO RECURSOS
create tablespace recursos_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/recursos01.dbf'
  size 100m
  autoextend on next 10m maxsize 300m
extent management local autoallocate
segment space management auto;

--TABLESPACE PARA ÍNDICES DEL MÓDULO USUARIOS_BIBLIOTECAS
create tablespace usuario_biblio_indexes_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/usuariosix01.dbf'
  size 5m
  autoextend on next 10m maxsize 100m
extent management local autoallocate
segment space management auto;

--tablespace PARA ÍNDICES DEL MÓDULO RECURSOS
create tablespace recursos_indexes_tbs
  datafile '/u01/app/oracle/oradata/GOTOPROY/recix01.dbf'
  size 5m
  autoextend on next 10m maxsize 100m
extent management local autoallocate
segment space management auto;