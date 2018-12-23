
SRCBRANCH = "linux-imx.4.1.15_2.amarel-develop"
SRC_URI = "git://github.com/netafimamarel/kernel-source.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "87d8d01dda2584b6f9efacb95b33afe91c92c577"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://cfg/mwifiex.cfg \
" 

