#!/bin/bash

echo "Memulai update DTRACK ..."

if cp DTRACK-GPS.db /home/pi/
then
    echo "Sukses salin DTRACK-GPS.db"
else
    echo "Gagal $?"
fi