FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://${PN}.initd"

do_install_append() {
    install -Dm 0755 ${WORKDIR}/${PN}.initd ${D}${sysconfdir}/init.d/${PN}
}
