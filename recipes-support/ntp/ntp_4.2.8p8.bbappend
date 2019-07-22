# Replace file /etc/ntp.conf

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
     file://ntp.conf \
 "

do_install_append() {
    install -m 644 ${WORKDIR}/ntp.conf ${D}${sysconfdir}

}



