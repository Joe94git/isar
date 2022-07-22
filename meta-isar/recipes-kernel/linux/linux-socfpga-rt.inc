DESCRIPTION = "Linux Kernel for Intel SoCFPGA"
LICENSE = "GPLv2"

KERNEL_REPO ?= "git://github.com/altera-opensource/linux-socfpga.git"
KERNEL_PROT ?= "https"

# Build branch name
LINUX_VERSION_PREFIX ?= "socfpga-"
LINUX_VERSION_SUFFIX ?= ""
LINUX_VERSION ?= "5.10.90"

KBRANCH ?= "${LINUX_VERSION_PREFIX}${LINUX_VERSION}${LINUX_VERSION_SUFFIX}"

require recipes-kernel/linux/linux-custom.inc

SRC_URI += "${KERNEL_REPO};protocol=${KERNEL_PROT};branch=${KBRANCH};destsuffix=${P}"

# Kernel CONFIG_LOCALVERSION

LINUX_VERSION_EXTENSION = "-isar"

SRCREV ?= "${AUTOREV}"
SRCREV_machine ?= "${AUTOREV}"

SRC_URI += "file://0001-arch-Kconfig-Enable-ARCH_SUPPORTS_RT.patch"
SRC_URI += "file://patch-5.10.90-rt61-rc1.patch.gz"
KERNEL_DEFCONFIG ?= "defconfig"
