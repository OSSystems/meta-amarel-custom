#
# Lora network Manager Amarel NIM project 
# Ruslan Sirota <ruslan@amarel.net> 
#

SUMMARY = "Lora network Manager Manager application/service"
SECTION = "base"
DEPENDS = "msc-cmake-scripts-native msc-linux-scripts glibc"
HOMEPAGE = "http://www.amarel.net/"
LICENSE = "GPLv2+"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

GIT_PATH 	= "nim/networkManagerLora"
GIT_SERVER  	= "192.168.2.111/"
GIT_USER        = "gitolite_u"
BRANCH         ?= "master"
SRCREV		= "635d0b2cacd77942ef81b44f38b81690e8193eed"
SRC_URI     	= "git://${GIT_SERVER}${GIT_PATH};tag=${SRCREV};branch=${BRANCH};prefer_premirror=1;protocol=ssh;user=${GIT_USER}"
# SRC_URI     	= "git://${GIT_SERVER}${GIT_PATH};tag=${SRCREV};branch=${BRANCH};prefer_premirror=1;protocol=ssh;user=${GIT_USER}"

S = "${WORKDIR}/git/"

PR = "r0"
# PV = "1.0.0+git${SRCPV}"

EXTRA_OEMAKE = "'CC=${CC}' 'CFLAGS=${CFLAGS} -DWITHOUT_XATTR' 'BUILDDIR=${S}'"

TARGET_CC_ARCH += "-pthread "
# TARGET_LD_ARCH += "-lpthread -mglibc -libpthread"

do_install () {
	# oe_runmake install DESTDIR=${D}
	oe_runmake
	install -d ${D}${base_bindir}/
	install -m 0755 ${S}/netwotkManagerLora ${D}${base_bindir}/
}

# Mark the files which are part of this package
FILES_${PN} += "{base_bindir}/netwotkManagerLora"

INSANE_SKIP_${PN} = "ldflags"

PARALLEL_MAKE = ""

BBCLASSEXTEND = "native"

