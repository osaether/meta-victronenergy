FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS += "update-rc.d-native"

SRC_URI += "\
	file://resolv.conf \
	file://resolv-watch \
	file://rw-init \
"

SRC_URI_append_beaglebone = "\
	file://dnsmasq.ap.conf \
"

RW_INITSCRIPT_PARAMS="start 80 5 . stop 10 0 1 6 ."

do_install_append() {
	install -m 644 ${WORKDIR}/resolv.conf ${D}${sysconfdir}

	install -d ${D}${sbindir}
	install -m 755 ${WORKDIR}/resolv-watch ${D}${sbindir}
	install -m 755 ${WORKDIR}/rw-init ${D}${sysconfdir}/init.d/resolv-watch
	update-rc.d -r ${D} resolv-watch ${RW_INITSCRIPT_PARAMS}
}

do_install_append_beaglebone() {
	install -m 644 ${WORKDIR}/dnsmasq.ap.conf ${D}${sysconfdir}
	ln -s dnsmasq ${D}${sysconfdir}/init.d/dnsmasq.ap
	update-rc.d -r ${D} dnsmasq.ap ${INITSCRIPT_PARAMS}
}
