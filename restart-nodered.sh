#!/bin/bash

echo "Restart Node-RED ... "
if sudo systemctl restart nodered.service
then
    echo "Restart sukses!"
else
    echo "Gagal $?"
fi