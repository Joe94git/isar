#
# Copyright (c) Siemens AG, 2018-2020
#
# SPDX-License-Identifier: MIT

require u-boot-socfpga-common.inc

COMPILE_PREPEND_FILES_agilex += " bl31.bin "
LIC_FILES_CHKSUM = "file://Licenses/README;md5=5a7450c57ffe5ae63fd732446b988025"

UBOOT_VERSION = "v2021.07"

SRCREV = "ee63370553cd01f7237174fe1971991271b7648b"
U_BOOT_TOOLS_PACKAGE = "1"


