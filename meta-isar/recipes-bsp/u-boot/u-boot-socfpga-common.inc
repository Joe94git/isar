HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
SECTION = "bootloaders"

DEBIAN_BUILD_DEPENDS += " swig, libssl-dev, python3-distutils, python3-dev, python3-setuptools, "
DEBIAN_BUILD_DEPENDS += " bc, bison, flex, device-tree-compiler, git"

require recipes-bsp/u-boot/u-boot-custom.inc

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM ?= "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
PE = "1"

UBOOT_REPO ?= "git://github.com/altera-opensource/u-boot-socfpga.git"
UBOOT_PROT ?= "https"

UBOOT_VERSION_PREFIX ?= "socfpga_"
UBOOT_VERSION ?= "v2021.07"
UBOOT_BRANCH ?= "${UBOOT_VERSION_PREFIX}${UBOOT_VERSION}"

SRC_URI += "${UBOOT_REPO};protocol=${UBOOT_PROT};branch=${UBOOT_BRANCH};destsuffix=${P}"
SRC_URI += "file://0001-u-boot-patch-manual-steps-2021.07.patch"

