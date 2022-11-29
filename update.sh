#!/bin/bash

echo "Memulai update DTRACK ..."
now=$( date +%Y-%m-%d %H:%M )

if test -f "/home/pi/.node-red/flows.json";
then
    mv /home/pi/.node-red/flows.json /home/pi/.node-red/flows_backup_$now.json 
    echo "Hapus flow lama: OK!"
fi

if cp DTRACK-GPS.db /home/pi/ && cp DTRACK-SPEED.db /home/pi/ && cp settingGPS.json /home/pi/ && cp -R node-red-contrib-kafka-manager /home/pi/.node-red/node_modules/ && cp -R node-red-contrib-nmea /home/pi/.node-red/node_modules/ && cp -R node-red-contrib-kafkajs /home/pi/.node-red/node_modules/ && cp flows.json /home/pi/.node-red/
then
    if test -f "/home/pi/.node-red/package.json"
    then
        mv /home/pi/.node-red/package.json /home/pi/.node-red/package_backup_$now.json 
        cp package.json /home/pi/.node-red/
        echo "Update package.json lama: OK!"
    else
        cp package.json /home/pi/.node-red/
    fi
    
    if test -f "/home/pi/.node-red/package-lock.json"
    then
        mv /home/pi/.node-red/package-lock.json /home/pi/.node-red/package-lock_backup_$now.json 
        cp package-lock.json /home/pi/.node-red/
        echo "Update package-lock.json lama: OK!"
    else
        cp package-lock.json /home/pi/.node-red/
    fi
    
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
