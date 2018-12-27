LICENSE_FLAGS = "oracle_java"
LICENSE = "Oracle_Binary_Code_License_Agreement"
LIC_FILES_CHKSUM = "\
	file://${JDK_JRE}${PV}_${PV_UPDATE}/LICENSE;md5=98f46ab6481d87c4d77e0e91a6dbc15f \
	file://${JDK_JRE}${PV}_${PV_UPDATE}/COPYRIGHT;md5=3dc1bfbd5bed75d650ad0506a0df5930 \
	file://${JDK_JRE}${PV}_${PV_UPDATE}/THIRDPARTYLICENSEREADME.txt;md5=745d6db5fc58c63f74ce6a7d4db7e695 \
	"

FETCHCMD_wget_append = " --header=Cookie:oraclelicense=a "

# get the java update version in the resulting package
PR =. "u${PV_UPDATE}"
S = "${WORKDIR}"

do_install () {
	install -d -m 0755					${D}${datadir}/${JDK_JRE}$1.8.0_${PV_UPDATE}
	cp -a ${S}/${JDK_JRE}1.8.0_${PV_UPDATE}			${D}${datadir}/
	install -d -m 0755					${D}${bindir}
	ln -sf ${datadir}/${JDK_JRE}1.8.0_${PV_UPDATE}/bin/java ${D}${bindir}/java
}

# All the files are provided in a binaray package, and keeping all the
# files in a single package causes packaging QA errors and warnings.
# Avoid these packaging failure by skiping all the QA checks
INSANE_SKIP_${PN} = "${ERROR_QA} ${WARN_QA}"

# Inhibit warnings about files being stripped, we can't do anything about it.
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

FILES_${PN} = "/usr/"
RPROVIDES_${PN} = "java2-runtime java2-vm"
PROVIDES += "virtual/java"
