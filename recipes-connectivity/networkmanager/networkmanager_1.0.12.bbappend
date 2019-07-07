
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
     file://NetworkManager.conf \
     file://interfaces \
 "

DEPENDS += " ppp wireless-tools"

PACKAGECONFIG += " ppp"
PACKAGECONFIG += " wifi"

EXTRA_OECONF_append = " \
    --with-nmcli=yes \
"

do_install_append() {
     install -d ${D}${sysconfdir}/network
     install -m 644   ${WORKDIR}/NetworkManager.conf       ${D}${sysconfdir}/NetworkManager/
     install -m 644   ${WORKDIR}/interfaces                ${D}${sysconfdir}/network/
}
