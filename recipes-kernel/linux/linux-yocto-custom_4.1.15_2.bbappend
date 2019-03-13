
SRCBRANCH = "linux-imx.4.1.15_2.amarel-develop"
SRC_URI = "git://github.com/netafimamarel/kernel-source.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "99f3254cd8edef8202181cd6b2afe27403660e37"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://cfg/mwifiex.cfg \
      file://cfg/virtual_terminal.cfg \
"
