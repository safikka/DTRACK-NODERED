#!/bin/bash

echo "Memulai update DTRACK ..."

if cp DTRACK-GPS.db /home/pi/ && cp DTRACK-SPEED.db /home/pi/ && cp settingGPS.json /home/pi/ && cp -R node-red-contrib-kafka-manager /home/pi/.node-red/node_modules/ && cp -R node-red-contrib-nmea /home/pi/.node-red/node_modules/
then
    echo "Sukses salin file Update!"
else
    echo "Gagal $?"
fi

if sudo systemctl restart nodered.service
then
    echo "Sukses restart Node-RED!"
else
    echo "Gagal $?"
fi
