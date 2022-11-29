#!/bin/bash

echo "Memulai update DTRACK ..."

if test -f "/home/pi/.node-red/flows.json";
then
    rm /home/pi/.node-red/flows.json
    echo "Hapus flow lama: OK!"
fi

if cp DTRACK-GPS.db /home/pi/ && cp DTRACK-SPEED.db /home/pi/ && cp settingGPS.json /home/pi/ && cp -R node-red-contrib-kafka-manager /home/pi/.node-red/node_modules/ && cp -R node-red-contrib-nmea /home/pi/.node-red/node_modules/ && cp -R node-red-contrib-kafkajs /home/pi/.node-red/node_modules/ && cp flows.json /home/pi/.node-red/ && cp package.json /home/pi/.node-red/
then
    echo "Sukses salin file Update!"
    echo "Update depedencies"
    if npm install
    then
        echo "Update depedencies sukses"
    else
        echo "Update depedencies gagal $?"
    fi
else
    echo "Gagal $?"
fi

if sudo systemctl restart nodered.service
then
    echo "Sukses restart Node-RED!"
else
    echo "Gagal $?"
fi
