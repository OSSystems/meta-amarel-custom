#!/bin/bash

if [ -z $1 ]; then
  echo " please provided download dir"
  exit 1
fi
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AcdcTile -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogIn -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogOut -d $1
#/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_IsmTile -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Power -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_Repeatera -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_RtuTile -d $1
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_IsmParentTile -d $1
/bin/get_bundle.py -p NetBeat       -b NetBeat_Installer -d $1
chmod a+x *.bsx
#create tile installer ( STM32 Programmer ) 
if [ -f /bin/tile_installer.tar.gz ]
then 
  # move all binaries to installer and create and installer
  # this installer performes STM32 JTAG programming out-of-the-box
  tar -zxvf /bin/tile_installer.tar.gz -C $1
  cp $1/*.bin $1/tile_installer/payload/
  cd $1/tile_installer
  ./build
  cp install_tile /bin
  cd ../
fi
