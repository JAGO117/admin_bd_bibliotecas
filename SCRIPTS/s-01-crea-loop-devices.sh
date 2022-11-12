#@Autor: Gonzalez Ochoa Jose Antonio
#        Torres Verastegui Jose Antonio
#@Fecha creación: 04/01/2022
#@Descripción: Creacion de loop devices, ejecuta ROOT
directorioBDA=/unam-bda/proyecto


cd /unam-bda/proyecto

if [ -f disk4.img ]; then
  rm -rf disk4.img
else 
  touch disk4.img
fi;

if [ -f disk5.img ]; then
  rm -rf disk5.img
else
  touch disk5.img
fi;



dd if=/dev/zero of=disk4.img bs=100M count=10
dd if=/dev/zero of=disk5.img bs=100M count=10


du -sh disk*.img
losetup -fP disk4.img
losetup -fP disk5.img

losetup -a
mkfs.ext4 disk4.img
mkfs.ext4 disk5.img


mkdir /u04
mkdir /u05

#mount -o loop /dev/loop2 /u04

#Modificaciones al archivo /etc/fstab
#/unam-bda/proyecto/disk4.img /u04 auto loop 0 0
#/unam-bda/proyecto/disk5.img /u05 auto loop 0 0


#
#
#
#
