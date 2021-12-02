# This software is a part of ISAR.
# Copyright (C) Siemens AG, 2019

update_etc_os_release() {
    OS_RELEASE_BUILD_ID=""
    OS_RELEASE_VARIANT=""
    OS_RELEASE_VARIANT_VERSION=""
    while true; do
        case "$1" in
        --build-id) OS_RELEASE_BUILD_ID=$2; shift ;;
        --variant) OS_RELEASE_VARIANT=$2; shift ;;
        --version) OS_RELEASE_VARIANT_VERSION=$2; shift ;;
        -*) bbfatal "$0: invalid option specified: $1" ;;
        *) break ;;
        esac
        shift
    done

    if [ -n "${OS_RELEASE_BUILD_ID}" ]; then
        sudo sed -i '/^BUILD_ID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
        echo "BUILD_ID=\"${OS_RELEASE_BUILD_ID}\"" | \
            sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
    fi
    if [ -n "${OS_RELEASE_VARIANT}" ]; then
        sudo sed -i '/^VARIANT=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
        echo "VARIANT=\"${OS_RELEASE_VARIANT}\"" | \
            sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
    fi
    if [ -n "${OS_RELEASE_VARIANT_VERSION}" ]; then
        sudo sed -i '/^VARIANT_VERSION=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
        echo "VARIANT_VERSION=\"${PV}\"" | \
            sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
    fi
}

ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_configure"
image_postprocess_configure() {
    # Configure root filesystem
    if [ -n "${DISTRO_CONFIG_SCRIPT}" ]; then
        sudo install -m 755 "${WORKDIR}/${DISTRO_CONFIG_SCRIPT}" "${IMAGE_ROOTFS}"
        TARGET_DISTRO_CONFIG_SCRIPT="$(basename ${DISTRO_CONFIG_SCRIPT})"
        sudo chroot ${IMAGE_ROOTFS} "/$TARGET_DISTRO_CONFIG_SCRIPT" \
                                    "${MACHINE_SERIAL}" "${BAUDRATE_TTY}"
        sudo rm "${IMAGE_ROOTFS}/$TARGET_DISTRO_CONFIG_SCRIPT"
   fi
}

ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_mark"
ROOTFS_POSTPROCESS_VARDEPS =+ "IMAGE_BUILD_ID"

image_postprocess_mark() {
    update_etc_os_release \
        --build-id "${IMAGE_BUILD_ID}" --variant "${DESCRIPTION}" --version "${PV}"
}

ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_machine_id"
image_postprocess_machine_id() {
    # systemd(1) takes care of recreating the machine-id on first boot
    sudo rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
    sudo install -m 644 '/dev/null' '${IMAGE_ROOTFS}/etc/machine-id'
}

ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_sshd_key_regen"

image_postprocess_sshd_key_regen() {
    nhkeys=$( find ${IMAGE_ROOTFS}/etc/ssh/ -iname "ssh_host_*key*" -printf '.' | wc -c )
    if [ $nhkeys -ne 0 -a ! -d ${IMAGE_ROOTFS}/usr/share/doc/sshd-regen-keys ]; then
       bbwarn "Looks like you have ssh host keys in the image but did "\
              "not install \"sshd-regen-keys\". This image should not be "\
              "deployed more than once."
       bberror "Install the package or forcefully remove this check!"
       exit 1
    fi
}
