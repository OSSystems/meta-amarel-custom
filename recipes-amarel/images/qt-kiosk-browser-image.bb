LICENSE = "CLOSED"

inherit core-image

CORE_IMAGE_EXTRA_INSTALL += " \
    init-ifupdown \
    ca-certificates \
    liberation-fonts \
    qt-kiosk-browser \
    qtbase-plugins \
    qtbase-tools \
"
