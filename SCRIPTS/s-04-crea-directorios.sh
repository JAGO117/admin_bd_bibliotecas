#@Autor: Gonzalez Ochoa Jose Antonio
#        Torres Verastegui Jose Antonio
#@Fecha creación: 04/01/2022
#@Descripción: Creacion de los directorios para la BD, ejecuta root
cd /u01/app/oracle/oradata
mkdir GOTOPROY
chown oracle:oinstall GOTOPROY
chmod 750 GOTOPROY

cd /u04
mkdir -p app/oracle/oradata/GOTOPROY
cd /u05
mkdir -p app/oracle/oradata/GOTOPROY

cd /u04
chown -R oracle:oinstall *
chmod -R 750 *
cd /u05
chown -R oracle:oinstall *
chmod -R 750 *
