
SRCBRANCH = "0584_ms2_iMX6_AES_develop"
SRC_URI = "git://github.com/netafimamarel/uboot.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "c1fddea55920c2b46ebb1bf0826b8b7f3de29777"
SRCREV_mx6 = "a3ec32927839bfa87458d576e47a0c71181518a3"

do_deploy_append() {
        install ${S}/uEnv.txt.amarel ${DEPLOYDIR}/uEnv.txt
}
