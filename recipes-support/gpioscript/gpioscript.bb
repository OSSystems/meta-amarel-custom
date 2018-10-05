#
# Copy the gpio manipulation script files to the target filesystem
# Ruslan Sirota <ruslan@amarel.net> 
#

SUMMARY = "gpio manipulation script files"
SECTION = "gpio utility"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
DESCRIPTION = "A configure gpio as input/output. Read/Modifyied values of GPIO. "

PR = "r1"

RDEPENDS_${PN} = "gpioscript"
RDEPENDS_${PN} += "bash"

SRC_URI = "file://gpio-get.sh;name=gpio-get"
SRC_URI += "file://gpio-set.sh;name=gpio-set"
SRC_URI += "file://get_bundle.py;name=get_bundle"
SRC_URI += "file://netafim_get_latest.sh;name=netafim_get_latest"
SRC_URI += "file://fsck.auto;name=fsck.auto"
SRC_URI = "file://burn.sh;name=burn"
SRC_URI += "file://tile_installer.tar.gz;name=tile_installer.tar.gz"


# SRC_URI[gpio-get.md5sum] = "f7c5bf0bbf9abb6db5d49745fae2d44b"
# SRC_URI[gpio-get.sha256sum] = "15c2c62fe9c595d9127b05a11b32c70ac91dd0bee8a9bea0a22db60e085a455"
# SRC_URI[gpio-set.md5sum] = "1ba0b33403c5436a865a6df2787ea89"
# SRC_URI[gpio-set.sha256sum] = "3526263e1b5670c22f2241ca6e3828efb9e36ff8d54b811de8af3ec021e6922"

S = "${WORKDIR}"

inherit allarch

# Install script on target's root filesystem
do_install () {
    # Install init script and default settings
    # ${sysconfdir}
    install -d ${D}${base_bindir}/
    install -m 0755 ${S}/gpio-get.sh ${D}${base_bindir}/
    install -m 0755 ${S}/gpio-set.sh ${D}${base_bindir}/
    install -m 0755 ${S}/get_bundle.py ${D}${base_bindir}/
    install -m 0755 ${S}/netafim_get_latest.sh ${D}${base_bindir}/
    install -m 0755 ${S}/gpio-get.sh ${D}${base_bindir}/
    install -m 0755 ${S}/fsck.auto ${D}${base_bindir}/
    install -m 0755 ${S}/burn.sh ${D}${base_bindir}/
    install -m 0755 ${S}/tile_installer.tar.gz ${D}${base_bindir}/

}

# Mark the files which are part of this package
FILES_${PN} += "{base_bindir}/netafim_get_latest.sh"
FILES_${PN} += "{base_bindir}/get_bundle.py"
FILES_${PN} += "{base_bindir}/burn.sh"
FILES_${PN} += "{base_bindir}/tile_installer.tar.gz"

