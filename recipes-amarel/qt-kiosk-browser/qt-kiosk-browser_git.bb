SUMMARY = "Qt Kiosk Browser"
DESCRIPTION = "Provides a simple but highly configurable browser \
for use on Kiosk devices"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"
LICENSE = "GPLv3"

DEPENDS = "qtwebengine"

SRC_URI = "git://github.com/OSSystems/qt-kiosk-browser;protocol=https"

PV = "0.0+git${SRCPV}"
SRCREV = "3f2288236d4ea6c28a107add10f0fec295b24cfe"

S = "${WORKDIR}/git"

inherit qmake5 systemd update-rc.d

EXTRA_QMAKEVARS_PRE += "PREFIX=${prefix}"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "${PN}.service"

INITSCRIPT_NAME = "${PN}"

do_install_append() {
    install -Dm 0644 ${S}/${PN}.conf ${D}${sysconfdir}/${PN}.conf
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -Dm 0644 ${S}/${PN}.service ${D}${systemd_system_unitdir}/${PN}.service
    fi
    if ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'true', 'false', d)}; then
        install -Dm 0755 ${S}/${PN}.initd ${D}${sysconfdir}/init.d/${PN}
    fi
}

RDEPENDS_${PN} += " \
    qtdeclarative-qmlplugins \
    qtquickcontrols-qmlplugins \
    qtvirtualkeyboard \
    qtwebengine-qmlplugins \
"
