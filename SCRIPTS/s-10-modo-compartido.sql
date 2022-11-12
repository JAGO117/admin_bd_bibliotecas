--@Autor: Gonzalez Ochoa Jose Antonio
--        Torres Verastegui Jose Antonio
--@Fecha creación: 08/01/2021
--@Descripción: Habilitacion del modo compartido


alter system set dispatchers='(dispatchers=2)(protocol=tcp)';
alter system set shared_servers=4;
show parameter dispatchers;
show parameter shared_servers;

--Configuracion del listener
alter system register;

!lsnrctl services

/* MODIFICACIONES AL ARCHIVO TNSNAMES.ORA
GOTOPROY_DEDICATED =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = pc-jago.fi.unam)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = gotoproy)
    )
  )

GOTOPROY_SHARED =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = pc-jago.fi.unam)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = SHARED)
      (SERVICE_NAME = gotoproy)
    )
  )

*/