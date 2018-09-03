DESCRIPTION = "Venus web app"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit daemontools ve_package www

RDEPENDS_${PN} = "hiawatha netcat"

SRC_URI = " \
	gitsm://github.com/victronenergy/${PN}.git;protocol=https;tag=${PV} \
"

S = "${WORKDIR}/git"
BASE_DIR = "${WWW_ROOT}/app"

DAEMONTOOLS_SERVICE_DIR = "${bindir}/service"
DAEMONTOOLS_RUN = "${bindir}/service_announcement.sh 80 /app"
DAEMONTOOLS_DOWN = "1"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	install -d ${D}${BASE_DIR}
	cp -a ${S}/app/* ${D}${BASE_DIR}

	install -d ${D}${bindir}
	install -m 0755 ${S}/service_announcement.sh ${D}${bindir}
}
