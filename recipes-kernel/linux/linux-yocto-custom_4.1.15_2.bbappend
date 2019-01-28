
SRCBRANCH = "linux-imx.4.1.15_2.amarel-develop"
SRC_URI = "git://github.com/netafimamarel/kernel-source.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "c35cc5b9bea086b302c713e8c7e0cd7afb76a72c"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://cfg/mwifiex.cfg \
" 

