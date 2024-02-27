#!/bin/bash

OPTS='--max-time 10'


echo "Clone y ejecute este script desde una de sus VMs"

function grade() {
 COMMAND=$1
 if [ "$2" == "nonull" ]
 then
  ${COMMAND}
 else
  ${COMMAND} &>/dev/null
 fi
 test $? -eq 0  && echo -e "OK" && return 0 || echo -e "FAILED" && return 1
}


UBUNTU="192.168.223.153" 
RHEL="192.168.223.153"

echo "Este usuario se utilizará para ambos sistemas"

read -p "USUARIO: " USER

echo $USER

echo "Ingreso SSH Ubuntu "

grade "ssh -l ${USER} ${UBUNTU} hostname"

echo "Ingreso SSH Red Hat "

grade "ssh -l ${USER} ${RHEL} hostname"

echo "Validar acceso a Web Server - Ubuntu "

grade "curl $OPTS http://${UBUNTU}"

echo "Validar acceso a Web Server - Red Hat "

grade "curl $OPTS http://${RHEL}"

echo "REALICE LOS CAMBIOS NECESARIO EN RHEL Y ACTIVE DE FORMA PERMANENTE EL ACCESO A PUERTO 80/443 (EN OTRA TERMINAL)"
read -p "PRESIONE ENTER, CUANDO ESTE LISTO"

echo "Validar acceso a Web Server - Red Hat "

grade "curl $OPTS http://${RHEL}"







