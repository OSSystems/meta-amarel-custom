FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://tslib-calibrate.initd \
"

inherit update-rc.d

INITSCRIPT_PACKAGES = "tslib-calibrate"
INITSCRIPT_NAME_tslib-calibrate = "tslib-calibrate"
INITSCRIPT_PARAMS_tslib-calibrate = "start 15 2 3 4 5 ."

do_install_append() {
    install -Dm 0755 ${WORKDIR}/tslib-calibrate.initd ${D}${sysconfdir}/init.d/tslib-calibrate
}

FILES_tslib-calibrate += " \
    ${sysconfdir}/init.d/tslib-calibrate \
"
