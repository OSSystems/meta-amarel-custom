FILESEXTRAPATHS_prepend := "${THISDIR}/python-imaging:"

#
# Add patch to resolve the issue of: "The compile log indicates that host include and/or library paths were used."
#

SRC_URI += "file://disable-link-to-host-tcl-lib.patch \
"

