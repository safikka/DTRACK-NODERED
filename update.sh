#!/bin/bash

echo "Memulai update DTRACK ...."
now=$( date + "%Y-%m-%d %H:%M" )

if test -f "/home/pi/.node-red/flows.json";
then
    mv /home/pi/.node-red/flows.json /home/pi/.node-red/flows_backup_$now.json 
    echo "Hapus flow lama: OK!"
fi

if cp DTRACK-GPS.db /home/pi/ && cp DTRACK-SPEED.db /home/pi/
then
    if test -f "/home/pi/settingGPS.json"
    then
        mv /home/pi/settingGPS.json /home/pi/settingGPS-backup.json
        cp settingGPS.json /home/pi/
        echo "Update settingGPS: OK!"
    else
        echo "File settingGPS tidak ada"
        cp settingGPS.json /home/pi/
        echo "Penambahan settingGPS.json: OK!"
    fi

    if test -a "/home/pi/.node-red"
    then
        mv /home/pi/.node-red /home/pi/.node-red-backup-last
        echo "Backup flow lama: OK!"
        sudo rm -r /home/pi/.node-red
        unzip -d /home/pi/ node-red-dtrack.zip
        mv /home/pi/node-red-dtrack /home/pi/.node-red
        echo "Update flow baru: OK!"
    else
        echo "Tidak ada file Flow lama"
        unzip -d /home/pi/ node-red-dtrack.zip
        mv /home/pi/node-red-dtrack /home/pi/.node-red
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