--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 04/01/2021
--@Descripción: Creación de registros

whenever sqlerror exit rollback;
set serveroutput on;
set define off;

Prompt **********************************
Prompt        Carga Inicial de datos
Prompt **********************************

connect sys/system3 as sysdba

create sequence admin_bi_us.seq_prestamo
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create sequence admin_re.seq_historico_status
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

create or replace directory TEMP as '/unam-bda/proyecto/BDA_PROYECTO/SCRIPTS';

alter table admin_bi_us.usuario nologging;
alter table admin_bi_us.prestamo nologging;
alter table admin_bi_us.prestamo_recurso nologging;
alter table admin_bi_us.biblioteca nologging;
alter table admin_bi_us.area_conocimiento nologging;
alter table admin_bi_us.biblioteca_area nologging;


alter table admin_re.status_recurso nologging;
alter table admin_re.editorial nologging;
alter table admin_re.autor nologging;
alter table admin_re.libro nologging;
alter table admin_re.libro_autor nologging;
alter table admin_re.revista nologging;
alter table admin_re.tesis nologging;
alter table admin_re.recurso nologging;
alter table admin_re.palabra_clave nologging;
alter table admin_re.libro_int nologging;
alter table admin_re.revista_int nologging;
alter table admin_re.tesis_int nologging;
alter table admin_re.historico_status nologging;



@biblioteca.sql
@area_conocimiento.sql
@biblioteca_area.sql
@status_recurso.sql
@editorial.sql
@autor.sql
@libro.sql
@libro_autor.sql
@revista.sql
@tesis.sql
@usuario.sql
@recurso.sql
@palabra_clave.sql
@libro_int.sql
@revista_int.sql
@tesis_int.sql
@historico_status.sql
@funcion_blob.sql
@insert_blobs.sql

commit;

alter table admin_bi_us.usuario logging;
alter table admin_bi_us.prestamo logging;
alter table admin_bi_us.prestamo_recurso logging;
alter table admin_bi_us.biblioteca logging;
alter table admin_bi_us.area_conocimiento logging;
alter table admin_bi_us.biblioteca_area logging;


alter table admin_re.status_recurso logging;
alter table admin_re.editorial logging;
alter table admin_re.autor logging;
alter table admin_re.libro logging;
alter table admin_re.libro_autor logging;
alter table admin_re.revista logging;
alter table admin_re.tesis logging;
alter table admin_re.recurso logging;
alter table admin_re.palabra_clave logging;
alter table admin_re.libro_int logging;
alter table admin_re.revista_int logging;
alter table admin_re.tesis_int logging;
alter table admin_re.historico_status logging;