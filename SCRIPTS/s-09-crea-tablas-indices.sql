--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 03/01/2021
--@Descripción: Creación de las tablas e indices con su asignacion de tablespace

connect admin_bi_us/1234
-- 
-- TABLE: AREA_CONOCIMIENTO 
--
CREATE TABLE AREA_CONOCIMIENTO(
    AREA_CONOCIMIENTO_ID    NUMBER(10, 0)    NOT NULL,
    NOMBRE                  VARCHAR2(40)     NOT NULL,
    CONSTRAINT AREA_CONOCIMIENTO_PK PRIMARY KEY (AREA_CONOCIMIENTO_ID)
    using index (
      create unique index area_conocimiento_pk on AREA_CONOCIMIENTO(AREA_CONOCIMIENTO_ID)
      tablespace usuario_biblio_indexes_tbs
    )
) tablespace usuarios_bibliotecas_tbs;

connect sys/system3 as sysdba
grant references on admin_bi_us.AREA_CONOCIMIENTO to admin_re;

connect admin_re/4321
-- 
-- TABLE: AUTOR 
--

CREATE TABLE AUTOR(
    AUTOR_ID    NUMBER(10, 0)    NOT NULL,
    NOMBRE      VARCHAR2(100)     NOT NULL,
    CONSTRAINT AUTOR_PK PRIMARY KEY (AUTOR_ID)
    using index (
      create unique index autor_pk on AUTOR(AUTOR_ID)
      tablespace recursos_indexes_tbs
    )
) tablespace recursos_tbs;


connect admin_bi_us/1234
-- 
-- TABLE: BIBLIOTECA 
--

CREATE TABLE BIBLIOTECA(
    BIBLIOTECA_ID    NUMBER(10, 0)    NOT NULL,
    NOMBRE           VARCHAR2(100)     NOT NULL,
    FOLIO            VARCHAR2(5)      NOT NULL,
    LATITUD          NUMBER(20, 2)    NOT NULL,
    LONGITUD         NUMBER(20, 2)    NOT NULL,
    DIRECCION_WEB    VARCHAR2(100)     NOT NULL,
    DIRECCION        VARCHAR2(100)     NOT NULL,
    CONSTRAINT BIBLIOTECA_PK PRIMARY KEY (BIBLIOTECA_ID)
    using index(
      create unique index biblioteca_pk on BIBLIOTECA(BIBLIOTECA_ID)
      tablespace usuario_biblio_indexes_tbs
    )
) tablespace usuarios_bibliotecas_tbs;

connect sys/system3 as sysdba
grant references on admin_bi_us.BIBLIOTECA to admin_re;

connect admin_bi_us/1234
-- 
-- TABLE: BIBLIOTECA_AREA 
--

CREATE TABLE BIBLIOTECA_AREA(
    AREA_CONOCIMIENTO_ID    NUMBER(10, 0)    NOT NULL,
    BIBLIOTECA_ID           NUMBER(10, 0)    NOT NULL,
    CONSTRAINT BIBLIOTECA_AREA_PK PRIMARY KEY (AREA_CONOCIMIENTO_ID, BIBLIOTECA_ID)
    using index(
      create unique index biblioteca_area_pk on BIBLIOTECA_AREA(AREA_CONOCIMIENTO_ID, BIBLIOTECA_ID)
      tablespace usuario_biblio_indexes_tbs
    ), 
    CONSTRAINT BIBLIOTECA_AREA_AREA_CONOCIMIENTO_ID_FK FOREIGN KEY (AREA_CONOCIMIENTO_ID)
    REFERENCES AREA_CONOCIMIENTO(AREA_CONOCIMIENTO_ID),
    CONSTRAINT BIBLIOTECA_AREA_BIBLIOTECA_ID_FK FOREIGN KEY (BIBLIOTECA_ID)
    REFERENCES BIBLIOTECA(BIBLIOTECA_ID)
) tablespace usuarios_bibliotecas_tbs;


connect admin_re/4321
-- 
-- TABLE: EDITORIAL 
--

CREATE TABLE EDITORIAL(
    EDITORIAL_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE           VARCHAR2(40)     NOT NULL,
    NOMBRE          VARCHAR2(100)     NOT NULL,
    DESCRIPCION     VARCHAR2(100)     NOT NULL,
    CONSTRAINT EDITORIAL_PK PRIMARY KEY (EDITORIAL_ID)
    using index(
      create unique index editorial_pk on EDITORIAL(EDITORIAL_ID)
      tablespace recursos_indexes_tbs
    )
) tablespace recursos_tbs;

-- 
-- TABLE: STATUS_RECURSO 
--

CREATE TABLE STATUS_RECURSO(
    STATUS_RECURSO_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE                VARCHAR2(20)     NOT NULL,
    DESCRIPCION          VARCHAR2(80)     NOT NULL,
    CONSTRAINT STATUS_RECURSO_PK PRIMARY KEY (STATUS_RECURSO_ID)
    using index(
      create unique index status_recurso_pk on STATUS_RECURSO(STATUS_RECURSO_ID)
      tablespace recursos_indexes_tbs
    )
) tablespace recursos_tbs;

-- 
-- TABLE: RECURSO 
--

CREATE TABLE RECURSO(
    RECURSO_ID              NUMBER(10, 0)    NOT NULL,
    NUMERO_CLASIFICACION    VARCHAR2(18)     NOT NULL,
    FECHA_ADQUISICION       DATE             NOT NULL,
    FECHA_STATUS            DATE             NOT NULL,
    AREA_CONOCIMIENTO_ID    NUMBER(10, 0)    NOT NULL,
    STATUS_RECURSO_ID       NUMBER(10, 0)    NOT NULL,
    RECURSO_ANTERIOR_ID     NUMBER(10, 0),
    RECURSO_TIPO            VARCHAR2(1)      NOT NULL,
    BIBLIOTECA_ID           NUMBER(10, 0)    NOT NULL,
    CONSTRAINT RECURSO_PK PRIMARY KEY (RECURSO_ID)
    using index(
      create unique index recurso_pk on RECURSO(RECURSO_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT RECURSO_AREA_CONOCIMIENTO_ID_FK FOREIGN KEY (AREA_CONOCIMIENTO_ID)
    REFERENCES admin_bi_us.AREA_CONOCIMIENTO(AREA_CONOCIMIENTO_ID),
    CONSTRAINT RECURSO_STATUS_RECURSO_FK FOREIGN KEY (STATUS_RECURSO_ID)
    REFERENCES STATUS_RECURSO(STATUS_RECURSO_ID),
    CONSTRAINT RECURSO_RECURSO_ANTERIOR_ID_FK FOREIGN KEY (RECURSO_ANTERIOR_ID)
    REFERENCES RECURSO(RECURSO_ID),
    CONSTRAINT RECURSO_BIBLIOTECA_ID_FK FOREIGN KEY (BIBLIOTECA_ID)
    REFERENCES admin_bi_us.BIBLIOTECA(BIBLIOTECA_ID)
) tablespace recursos_tbs;

create index recurso_area_conocimiento_id_ix on RECURSO(AREA_CONOCIMIENTO_ID)
tablespace recursos_indexes_tbs;

create index recurso_status_recurso_id_ix on RECURSO(STATUS_RECURSO_ID)
tablespace recursos_indexes_tbs;

create index recurso_recurso_anterior_id_ix on RECURSO(RECURSO_ANTERIOR_ID)
tablespace recursos_indexes_tbs;

create index recurso_biblioteca_id_ix on RECURSO(BIBLIOTECA_ID)
tablespace recursos_indexes_tbs;

connect sys/system3 as sysdba
grant references on admin_re.RECURSO to admin_bi_us;

connect admin_re/4321
-- 
-- TABLE: HISTORICO_STATUS 
--

CREATE TABLE HISTORICO_STATUS(
    HISTORICO_STATUS_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_STATUS           DATE             NOT NULL,
    STATUS_RECURSO_ID      NUMBER(10, 0)    NOT NULL,
    RECURSO_ID             NUMBER(10, 0)    NOT NULL,
    CONSTRAINT HISTORICO_STATUS_PK PRIMARY KEY (HISTORICO_STATUS_ID)
    using index(
      create unique index historico_status_pk on HISTORICO_STATUS(HISTORICO_STATUS_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT HISTORICO_STATUS_STATUS_RECURSO_ID_FK FOREIGN KEY (STATUS_RECURSO_ID)
    REFERENCES STATUS_RECURSO(STATUS_RECURSO_ID),
    CONSTRAINT HISTORICO_STATUS_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES RECURSO(RECURSO_ID)
) tablespace recursos_tbs;

create index historico_status_status_recurso_id_ix on HISTORICO_STATUS(STATUS_RECURSO_ID)
tablespace recursos_indexes_tbs;

create index historico_status_recurso_id_ix on HISTORICO_STATUS(RECURSO_ID)
tablespace recursos_indexes_tbs;

-- 
-- TABLE: LIBRO 
--

CREATE TABLE LIBRO(
    LIBRO_ID        NUMBER(10, 0)    NOT NULL,
    ISBN            VARCHAR2(40)     NOT NULL,
    TITULO          VARCHAR2(150)     NOT NULL,
    PDF             BLOB             NOT NULL,
    EDITORIAL_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT LIBRO_PK PRIMARY KEY (LIBRO_ID)
    using index(
      create unique index libro_pk on LIBRO(LIBRO_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT LIBRO_EDITORIAL_ID_FK FOREIGN KEY (EDITORIAL_ID)
    REFERENCES EDITORIAL(EDITORIAL_ID)
) tablespace recursos_tbs LOB (PDF) STORE AS (TABLESPACE recursos_blob_tbs);

create index libro_editorial_id_ix on LIBRO(EDITORIAL_ID)
tablespace recursos_indexes_tbs;

-- 
-- TABLE: LIBRO_AUTOR 
--

CREATE TABLE LIBRO_AUTOR(
    LIBRO_AUTOR_ID    NUMBER(10, 0)    NOT NULL,
    AUTOR_ID          NUMBER(10, 0)    NOT NULL,
    LIBRO_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT LIBRO_AUTOR_PK PRIMARY KEY (LIBRO_AUTOR_ID)
    using index(
      create unique index libro_autor_pk on LIBRO_AUTOR(LIBRO_AUTOR_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT LIBRO_AUTOR_LIBRO_ID_FK FOREIGN KEY (LIBRO_ID)
    REFERENCES LIBRO(LIBRO_ID),
    CONSTRAINT LIBRO_AUTOR_AUTOR_ID_FK FOREIGN KEY (AUTOR_ID)
    REFERENCES AUTOR(AUTOR_ID)
) tablespace recursos_tbs;

create index libro_autor_autor_id_ix on LIBRO_AUTOR(AUTOR_ID)
tablespace recursos_indexes_tbs;

create index libro_autor_libro_id_ix on LIBRO_AUTOR(LIBRO_ID)
tablespace recursos_indexes_tbs;

create unique index libro_autor_autor_id_libro_id_ix on LIBRO_AUTOR(AUTOR_ID, LIBRO_ID)
tablespace recursos_indexes_tbs;

-- 
-- TABLE: LIBRO_INT 
--

CREATE TABLE LIBRO_INT(
    RECURSO_ID    NUMBER(10, 0)    NOT NULL,
    LIBRO_ID      NUMBER(10, 0)    NOT NULL,
    CONSTRAINT LIBRO_INT_PK PRIMARY KEY (RECURSO_ID)
    using index(
      create unique index libro_int_pk on LIBRO_INT(RECURSO_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT LIBRO_INT_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES RECURSO(RECURSO_ID),
    CONSTRAINT LIBRO_INT_LIBRO_ID_FK FOREIGN KEY (LIBRO_ID)
    REFERENCES LIBRO(LIBRO_ID)
) tablespace recursos_tbs;

create index libro_int_libro_id_ix on LIBRO_INT(LIBRO_ID)
tablespace recursos_indexes_tbs;

-- 
-- TABLE: PALABRA_CLAVE 
--

CREATE TABLE PALABRA_CLAVE(
    PALABRA_ID    NUMBER(10, 0)    NOT NULL,
    PALABRA       VARCHAR2(50)     NOT NULL,
    RECURSO_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PALABRA_CLAVE_PK PRIMARY KEY (PALABRA_ID)
    using index(
      create unique index palabra_clave_pk on PALABRA_CLAVE(PALABRA_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT PALABRA_CLAVE_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES RECURSO(RECURSO_ID)
) tablespace recursos_tbs;

create index palabra_clave_recurso_id_ix on PALABRA_CLAVE(RECURSO_ID)
tablespace recursos_indexes_tbs;

create unique index palabra_clave_palabra_recurso_id_ix on PALABRA_CLAVE(PALABRA, RECURSO_ID)
tablespace recursos_indexes_tbs;


connect admin_bi_us/1234

-- 
-- TABLE: USUARIO 
--

CREATE TABLE USUARIO(
    USUARIO_ID          NUMBER(10, 0)    NOT NULL,
    NOMBRE              VARCHAR2(40)     NOT NULL,
    APELLIDO_PATERNO    VARCHAR2(40)     NOT NULL,
    APELLIDO_MATERNO    VARCHAR2(40),
    MATRICULA           VARCHAR2(20)    NOT NULL,
    EMAIL               VARCHAR2(100)     NOT NULL,
    SEMESTRE            NUMBER(2, 0),
    USERNAME            VARCHAR2(40)     NOT NULL,
    PASSWORD            VARCHAR2(40)     NOT NULL,
    FOTO                BLOB             NOT NULL,
    CON_PRESTAMO        NUMBER(1, 0)     NOT NULL,
    PRESTAMO_VENCIDO    NUMBER(1, 0)     NOT NULL,
    CONSTRAINT USUARIO_PK PRIMARY KEY (USUARIO_ID)
    using index(
      create unique index usuario_pk on USUARIO(USUARIO_ID)
      tablespace usuario_biblio_indexes_tbs
    )
) tablespace usuarios_bibliotecas_tbs LOB (FOTO) STORE AS (TABLESPACE usuarios_bibliotecas_blob_tbs);


-- 
-- TABLE: PRESTAMO 
--

CREATE TABLE PRESTAMO(
    PRESTAMO_ID      NUMBER(10, 0)    NOT NULL,
    USUARIO_ID       NUMBER(10, 0)    NOT NULL,
    NUM_PRESTAMO     NUMBER(10, 0)    NOT NULL,
    FECHA_ENTREGA    DATE             NOT NULL,
    IMPORTE_MULTA    NUMBER(5, 0),
    CONSTRAINT PRESTAMO_PK PRIMARY KEY (PRESTAMO_ID)
    using index(
      create unique index prestamo_pk on PRESTAMO(PRESTAMO_ID)
      tablespace usuario_biblio_indexes_tbs
    ), 
    CONSTRAINT PRESTAMO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES USUARIO(USUARIO_ID)
) tablespace usuarios_bibliotecas_tbs;

create index presatmo_usuario_id_ix on PRESTAMO(USUARIO_ID)
tablespace usuario_biblio_indexes_tbs;

create unique index prestamo_num_indice_usuario_ix on PRESTAMO(USUARIO_ID, NUM_PRESTAMO)
tablespace usuario_biblio_indexes_tbs;


-- 
-- TABLE: PRESTAMO_RECURSO 
--

CREATE TABLE PRESTAMO_RECURSO(
    PRESTAMO_ID    NUMBER(10, 0)    NOT NULL,
    RECURSO_ID     NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PRESTAMO_RECURSO_PK PRIMARY KEY (PRESTAMO_ID, RECURSO_ID)
    using index(
      create unique index prestamo_recurso_pk on PRESTAMO_RECURSO(PRESTAMO_ID, RECURSO_ID)
      tablespace usuario_biblio_indexes_tbs
    ), 
    CONSTRAINT PRESTAMO_RECURSO_PRESTAMOS_ID_FK FOREIGN KEY (PRESTAMO_ID)
    REFERENCES PRESTAMO(PRESTAMO_ID),
    CONSTRAINT PRESTAMO_RECURSO_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES admin_re.RECURSO(RECURSO_ID)
) tablespace usuarios_bibliotecas_tbs;


connect admin_re/4321
-- 
-- TABLE: REVISTA 
--

CREATE TABLE REVISTA(
    REVISTA_ID           NUMBER(10, 0)    NOT NULL,
    TITULO               VARCHAR2(150)     NOT NULL,
    SINOPSIS             VARCHAR2(100)    NOT NULL,
    FECHA_PUBLICACION    DATE             NOT NULL,
    NOMBRE_EMPRESA       VARCHAR2(50)     NOT NULL,
    NUMERO_EDICION       NUMBER(3, 0)     NOT NULL,
    CONSTRAINT REVISTA_PK PRIMARY KEY (REVISTA_ID)
    using index(
      create unique index revista_pk on REVISTA(REVISTA_ID)
      tablespace recursos_indexes_tbs
    )
) tablespace recursos_tbs;



-- 
-- TABLE: REVISTA_INT 
--

CREATE TABLE REVISTA_INT(
    RECURSO_ID    NUMBER(10, 0)    NOT NULL,
    REVISTA_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT REVISTA_INT_PK PRIMARY KEY (RECURSO_ID)
    using index(
      create unique index revista_int_pk on REVISTA_INT(recurso_id)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT REVISTA_INT_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES RECURSO(RECURSO_ID),
    CONSTRAINT REVISTA_INT_REVISTA_ID_FK FOREIGN KEY (REVISTA_ID)
    REFERENCES REVISTA(REVISTA_ID)
) tablespace recursos_tbs;

create index revista_int_revista_id_ix on REVISTA_INT(REVISTA_ID)
tablespace recursos_indexes_tbs;

-- 
-- TABLE: TESIS 
--

CREATE TABLE TESIS(
    TESIS_ID             NUMBER(10, 0)    NOT NULL,
    TITULO               VARCHAR2(100)     NOT NULL,
    NOMBRE_TESISTA       VARCHAR2(100)     NOT NULL,
    CARRERA              VARCHAR2(100)     NOT NULL,
    UNIVERSIDAD          VARCHAR2(100)     NOT NULL,
    FECHA_PUBLICACION    DATE             NOT NULL,
    PDF                  BLOB,
    CONSTRAINT TESIS_PK PRIMARY KEY (TESIS_ID)
    using index(
      create unique index tesis_pk on TESIS(TESIS_ID)
      tablespace recursos_indexes_tbs
    )
) tablespace recursos_tbs LOB (PDF) STORE AS (TABLESPACE recursos_blob_tbs);



-- 
-- TABLE: TESIS_INT 
--

CREATE TABLE TESIS_INT(
    RECURSO_ID    NUMBER(10, 0)    NOT NULL,
    TESIS_ID      NUMBER(10, 0)    NOT NULL,
    CONSTRAINT TESIS_INT_PK PRIMARY KEY (RECURSO_ID)
    using index(
      create unique index tesis_int_pk on TESIS_INT(RECURSO_ID)
      tablespace recursos_indexes_tbs
    ), 
    CONSTRAINT TESIS_INT_RECURSO_ID_FK FOREIGN KEY (RECURSO_ID)
    REFERENCES RECURSO(RECURSO_ID),
    CONSTRAINT TESIS_INT_TESIS_ID_FK FOREIGN KEY (TESIS_ID)
    REFERENCES TESIS(TESIS_ID)
) tablespace recursos_tbs;

create index tesis_int_tesis_id_ix on TESIS_INT(TESIS_ID)
tablespace recursos_indexes_tbs;


--INDICES PARTICULARES CASO DE ESTUDIO

create index no_clasificacion_ix on RECURSO(NUMERO_CLASIFICACION)
tablespace recursos_indexes_tbs;

create index palabra_ix on PALABRA_CLAVE(PALABRA)
tablespace recursos_indexes_tbs;

create unique index isbn_ix on LIBRO(ISBN)
tablespace recursos_indexes_tbs;


connect admin_bi_us/1234

create unique index folio_ix on BIBLIOTECA(FOLIO)
tablespace usuario_biblio_indexes_tbs;