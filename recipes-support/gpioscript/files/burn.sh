#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'


if [ -z $1 ]; then
   echo "Plaese provide Image Name"
   exit 1
fi
echo "Programming $1, this may take a minute,please wait ..." 
st-flash write $1 0x8000000 > /dev/null 2>&1
if [ $? -eq 0 ]
then 
    echo -e "${GREEN}Success${NC}"
else
    echo -e "${RED}Could not program image..please check connections${NC}"
fi

