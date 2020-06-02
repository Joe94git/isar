# Base image recipe for ISAR
#
# This software is a part of ISAR.
# Copyright (C) 2015-2018 ilbers GmbH

DESCRIPTION = "CES X11 demo image"

# LICENSE = "gpl-2.0"
# LIC_FILES_CHKSUM = "file://${LAYERDIR_core}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"

PV = "1.0"

IMAGE_PREINSTALL += " lightdm lxde"

inherit image
