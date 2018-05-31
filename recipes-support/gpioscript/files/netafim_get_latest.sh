#!/bin/bash

if [ -z $1 ]; then
  echo " please provided download dir"
  exit 1
fi
./get_bundle.py -p NetBeat_Tiles -b NetBeat_AcdcTile -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogIn -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogOut -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_IsmTile -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_Power -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_Repeatera -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_RtuTile -d $1
./get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_IsmParentTile -d $1
./get_bundle.py -p NetBeat       -b NetBeat_Installer -d $1
chomd a+x *.bsx
