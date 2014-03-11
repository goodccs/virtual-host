#!/bin/bash
  
if [ -z $1 ]
then
echo "Debe ingresar el nombre del dominio"
exit 1
else
DOMINIO=$1
fi
  
echo "Desconfigurando dominio "$DOMINIO
  
#REMOVEMOS DE APACHE
a2dissite $DOMINIO
  
#BORRAMOS LA CONFIGURACION PARA APACHE
rm /etc/apache2/sites-available/$DOMINIO
  
#BORRAMOS EL DOMINIO LOCAL
sed  "/$DOMINIO/ d" -i /etc/hosts
  
#REINICIAMOS APACHE
/etc/init.d/apache2 reload
  
echo "Listo!"
