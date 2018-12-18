
SRCBRANCH = "linux-imx.4.1.15_2.amarel-develop"
SRC_URI = "git://github.com/netafimamarel/kernel-source.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "6513363031c2e03b3d0b0ad8f20d40ad3b18e391"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://cfg/mwifiex.cfg \
" 

