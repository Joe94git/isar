LINUX_VERSION ="${PV}"
LINUX_VERSION_SUFFIX = "-lts"

#LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

#Commit ID 
SRCREV = "3fcad989621b08e5d3e4f7cd4ea8e5631fec356d"

include linux-socfpga-rt.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/config:"

SRC_URI += "file://defconfig "

SRC_URI_append_agilex = " file://jffs2.scc file://gpio_sys.scc "

