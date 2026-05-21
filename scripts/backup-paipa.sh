#!/bin/bash
FECHA=$(date +%Y%m%d-%H%M)
DESTINO=~/backups/paipa-$FECHA
TOKEN="8829044380:AAE8mkW29W6aL67gXVtYsrN_InFU-MFrocA"
CHAT_ID="8238037926"
mkdir -p $DESTINO

# Función de alerta Telegram
alerta() {
  curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$1" > /dev/null
}

# Backup BD desde VM2
ssh adminpaipa@192.168.1.110 \
  "docker exec paipa-db sh -c 'exec mysqldump --all-databases -uroot -p\"\$MYSQL_ROOT_PASSWORD\"'" \
  > $DESTINO/databases.sql

if [ $? -ne 0 ]; then
  alerta "❌ ERROR: Backup BD fallido - $FECHA"
else
  echo "BD backup OK"
fi

# Backup archivos PrestaShop desde LXC1
ssh root@192.168.1.100 \
  "tar -czf - -C ~/prestashop-paipa data" \
  > $DESTINO/prestashop-files.tar.gz

if [ $? -ne 0 ]; then
  alerta "❌ ERROR: Backup archivos fallido - $FECHA"
else
  echo "Archivos backup OK"
fi

# Verificar integridad con tar -tzf
tar -tzf $DESTINO/prestashop-files.tar.gz > /dev/null 2>&1
if [ $? -ne 0 ]; then
  alerta "❌ ERROR: Backup corrupto - $FECHA"
  echo "ERROR: archivo corrupto"
else
  echo "Verificación integridad OK"
fi

# Empaquetar
tar -czf $DESTINO.tar.gz -C ~/backups paipa-$FECHA
rm -rf $DESTINO

# Retención 7 días
find ~/backups -name 'paipa-*.tar.gz' -mtime +7 -delete

# Notificación de éxito
alerta "✅ Backup completado exitosamente - $FECHA - Tiendas Paipa Online"
echo "Backup completado: $DESTINO.tar.gz"
