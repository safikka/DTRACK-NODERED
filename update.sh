#!/bin/bash

echo "Memulai update DTRACK ..."
now=$( date + "%Y-%m-%d %H:%M" )

if test -f "/home/pi/.node-red/flows.json";
then
    mv /home/pi/.node-red/flows.json /home/pi/.node-red/flows_backup_$now.json 
    echo "Hapus flow lama: OK!"
fi

if cp DTRACK-GPS.db /home/pi/ && cp DTRACK-SPEED.db /home/pi/ && cp settingGPS.json /home/pi/
then
    if test -a "/home/pi/.node-red"
    then
        mv /home/pi/.node-red /home/pi/.node-red-backup-$now
        echo "Backup flow lama: OK!"
        unzip -d /home/pi/dtrack node-red-dtrack.zip
        mv /home/pi/dtrack /home/pi/.node-red
        echo "Update flow baru: OK!"
    else
        echo "Tidak ada file Flow lama"
        unzip -d /home/pi/dtrack node-red-dtrack.zip
        mv /home/pi/dtrack /home/pi/.node-red
        echo "Update flow baru: OK!"
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
