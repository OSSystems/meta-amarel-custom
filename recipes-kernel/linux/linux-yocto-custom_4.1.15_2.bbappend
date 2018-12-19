
SRCBRANCH = "linux-imx.4.1.15_2.amarel-develop"
SRC_URI = "git://github.com/netafimamarel/kernel-source.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "bfebc4dae0f75320460761716b0e57d566c7dd58"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://cfg/mwifiex.cfg \
" 

