#!/bin/bash

if [ "$USER" == "admin" ] || [ "$USER" == "root" ] || [ "$USER" == "" ];then
    echo ""
else
    python /opt/easeserver/connect.py
    if [ $USER == 'guanghongwei' ];then
        echo
    else
        exit 3
        echo
    fi
fi