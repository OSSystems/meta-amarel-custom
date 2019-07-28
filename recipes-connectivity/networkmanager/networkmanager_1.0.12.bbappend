
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
     file://NetworkManager.conf \
     file://interfaces \
     file://NetworkManager \
     file://nm_monitor \
     file://nm_runner \
 "

DEPENDS += " ppp wireless-tools"

PACKAGECONFIG += " ppp"
PACKAGECONFIG += " wifi"

EXTRA_OECONF_append = " \
    --with-nmcli=yes \
"

# these 3 lines will have the script run on boot
inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME = "NetworkManager.in"

do_install_append() {
     install -d ${D}${sysconfdir}/network
     install -m 644   ${WORKDIR}/NetworkManager.conf       ${D}${sysconfdir}/NetworkManager/
     install -m 644   ${WORKDIR}/interfaces                ${D}${sysconfdir}/network/

     install -d ${D}${sysconfdir}/init.d
     install -m 0755 ${WORKDIR}/NetworkManager      ${D}${sysconfdir}/init.d/

     install -m 0755 ${WORKDIR}/nm_monitor      ${D}${sysconfdir}/init.d/
     install -m 0755 ${WORKDIR}/nm_runner      ${D}${sysconfdir}/init.d/
     update-rc.d -r ${D} nm_runner start 99 2 3 4 5 .
     update-rc.d -r ${D} nm_runner stop  99 0 1 6 .

     update-rc.d -f hostapd remove
     update-rc.d -f dnsmasq remove
}
