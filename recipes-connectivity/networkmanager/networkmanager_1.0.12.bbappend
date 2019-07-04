
DEPENDS += " ppp wireless-tools"

PACKAGECONFIG += " ppp"
PACKAGECONFIG += " wifi"

EXTRA_OECONF_append = " \
    --with-nmcli=yes \
"

