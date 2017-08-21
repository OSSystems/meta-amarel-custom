#
# rs485 manager Amarel NIM project 
# Ruslan Sirota <ruslan@amarel.net> 
#

SUMMARY = "rs485 Manager application/service"
SECTION = "base"
DEPENDS = "msc-cmake-scripts-native msc-linux-scripts glibc"
HOMEPAGE = "http://www.amarel.net/"
LICENSE = "GPLv2+"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

GIT_PATH 	= "nim/rs485Manager.git"
GIT_SERVER  	= "192.168.2.111/"
GIT_USER        = "gitolite_u"
BRANCH         ?= "master"
SRCREV		= "4a2038857ded71b82da71df83c1c199d12fd9aec"
SRC_URI     	= "git://${GIT_SERVER}${GIT_PATH};tag=${SRCREV};branch=${BRANCH};prefer_premirror=1;protocol=ssh;user=${GIT_USER}"
# SRC_URI     	= "git://${GIT_SERVER}${GIT_PATH};tag=${SRCREV};branch=${BRANCH};prefer_premirror=1;protocol=ssh;user=${GIT_USER}"

S = "${WORKDIR}/git"

PR = "r0"
# PV = "1.0.0+git${SRCPV}"

EXTRA_OEMAKE = "'CC=${CC}' 'CFLAGS=${CFLAGS} -DWITHOUT_XATTR' 'BUILDDIR=${S}'"

TARGET_CC_ARCH += "-pthread "
# TARGET_LD_ARCH += "-lpthread -mglibc -libpthread"

do_install () {
	# oe_runmake install DESTDIR=${D}
	oe_runmake
	install -d ${D}${base_bindir}/
	install -m 0755 ${S}/rs485Manager ${D}${base_bindir}/
}

# Mark the files which are part of this package
FILES_${PN} += "{base_bindir}/rs485Manager"

INSANE_SKIP_${PN} = "ldflags"

PARALLEL_MAKE = ""

BBCLASSEXTEND = "native"

