#!/bin/bash
# Script de restauración de backup — Tiendas Paipa Online
# Ejecutar desde LXC3 (192.168.1.120)
# Uso: ./restore-paipa.sh paipa-20260521-0200.tar.gz

if [ -z "$1" ]; then
  echo "Uso: $0 <archivo-backup.tar.gz>"
  echo "Backups disponibles:"
  ls ~/backups/paipa-*.tar.gz
  exit 1
fi

BACKUP=$1
TEMP=/tmp/restore-$(date +%Y%m%d-%H%M)
mkdir -p $TEMP

echo "Extrayendo backup: $BACKUP"
tar -xzf $BACKUP -C $TEMP

CARPETA=$(ls $TEMP)

# Restaurar BD en VM2
echo "Restaurando base de datos en VM2..."
scp $TEMP/$CARPETA/databases.sql adminpaipa@192.168.1.110:/tmp/
ssh adminpaipa@192.168.1.110 \
  "docker exec -i paipa-db sh -c 'exec mysql -uroot -p\"\$MYSQL_ROOT_PASSWORD\"' < /tmp/databases.sql"

if [ $? -eq 0 ]; then
  echo "Base de datos restaurada correctamente"
else
  echo "ERROR: fallo al restaurar la base de datos"
  exit 1
fi

# Restaurar archivos PrestaShop en LXC1
echo "Restaurando archivos PrestaShop en LXC1..."
scp $TEMP/$CARPETA/prestashop-files.tar.gz root@192.168.1.100:/tmp/
ssh root@192.168.1.100 \
  "cd ~/prestashop-paipa && tar -xzf /tmp/prestashop-files.tar.gz && docker compose restart"

if [ $? -eq 0 ]; then
  echo "PrestaShop restaurado correctamente"
else
  echo "ERROR: fallo al restaurar PrestaShop"
  exit 1
fi

rm -rf $TEMP
echo "Restauración completada exitosamente"
