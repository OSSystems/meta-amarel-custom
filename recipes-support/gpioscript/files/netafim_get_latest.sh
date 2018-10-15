#!/bin/bash -x

if [ -z $1 ]; then
  echo " no download dir is specified, using /tmp "
  DL_DIR="/tmp"
else
  DL_DIR=$1
fi

rm $DL_DIR/*.bsx
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AcdcTile -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogIn -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_AnalogOut -d $DL_DIR
#/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_IsmTile -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Power -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_Repeatera -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_RtuTile -d $DL_DIR
/bin/get_bundle.py -p NetBeat_Tiles -b NetBeat_Tiles_IsmParentTile -d $DL_DIR
/bin/get_bundle.py -p NetBeat       -b NetBeat_Installer -d $DL_DIR
/bin/get_bundle.py -p NetBeat       -b NetBeat_ProductionTests -d $DL_DIR
chmod a+x $DL_DIR/*.bsx
rm /usr/sbin/*.bsx

cp $DL_DIR/*.bsx /usr/sbin/
#create tile installer ( STM32 Programmer ) 
if [ -f /bin/tile_installer.tar.gz ]
then 
  # move all binaries to installer and create and installer
  # this installer performes STM32 JTAG programming out-of-the-box
  tar -zxvf /bin/tile_installer.tar.gz -C $DL_DIR
  cp $DL_DIR/*.bin $DL_DIR/tile_installer/payload/
  cd $DL_DIR/tile_installer
  ./build
  cp $DL_DIR/tile_installer/install_tile /bin
  cd ../
fi
mkdir -p production_tests
tar -zxvf $DL_DIR/production_tests.tar.gz -C $DL_DIR/production_tests > /dev/null
