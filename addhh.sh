#!/bin/bash
  
if [ -z $1 ]
then
    echo "Debe ingresar el nombre del dominio"
    exit 1
else
    DOMINIO=$1
fi
  
if [ -z $2 ]
then
    RUTA="/var/www/"
else
    RUTA=$2
fi
  
echo "Configurando dominio "$DOMINIO
  
#CREAMOS LA ENTRADA EN /ETC/HOSTS
echo "127.0.0.1 "$DOMINIO >> /etc/hosts
  
#CREAMOS EL ARCHIVO DE VIRTUAL HOST
touch /etc/apache2/sites-available/$DOMINIO
  
#AGREGAMOS EL VIRTUAL HOST
echo "<VirtualHost *:80>
    ServerAdmin god@$DOMINIO
    ServerName  *.$DOMINIO
    ServerAlias $DOMINIO
  
    DocumentRoot $RUTA$DOMINIO/
    <Directory />
        Options FollowSymLinks
        AllowOverride All
    </Directory>
    <Directory $RUTA$DOMINIO/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>" > /etc/apache2/sites-available/$DOMINIO
  
#CREAMOS EL DIRECTORIO PARA EL DOMINIO
mkdir $RUTA$DOMINIO
chmod 775 $RUTA$DOMINIO
chown www-data:www-data $RUTA$DOMINIO
  
#CONFIGURAMOS APACHE
a2ensite $DOMINIO
  
#REINICIAMOS APACHE
/etc/init.d/apache2 reload
  
echo "Listo!"
