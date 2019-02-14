SUMMARY = "HTML5 example"
LICENSE = "CLOSED"

SRC_URI = "file://${PN}.tar.gz"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    install -d ${D}${datadir}/${PN}
    cp -rf ${WORKDIR}/${PN} ${D}${datadir}/
}

FILES_${PN} += "${datadir}/${PN}"
