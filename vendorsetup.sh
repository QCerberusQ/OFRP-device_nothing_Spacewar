#
# vendorsetup.sh – Spacewar (Boot Image Based / Header v3)
#

if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: This script requires bash."
    return 1
fi

export LC_ALL="C"

# -----------------------------------------------------------------------
# Device & Build Info
export FOX_BUILD_DEVICE="Spacewar"
export FOX_TARGET_DEVICES="Spacewar,spacewar"
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Beta"
export FOX_VARIANT="BaR"

# -----------------------------------------------------------------------
# Install Target (critical for bootimage-based recovery)
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

# -----------------------------------------------------------------------
# A/B & Virtual AB
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1

# -----------------------------------------------------------------------
# Screen / UI
export OF_SCREEN_H=2400
export OF_SCREEN_W=1080
export OF_STATUS_H=115
export OF_STATUS_INDENT_LEFT=165
export OF_STATUS_INDENT_RIGHT=48
export OF_HIDE_NOTCH=1
export OF_CLOCK_POS=0
export TW_THEME="portrait_hdpi"
export TW_MAX_BRIGHTNESS=2047
export TW_DEFAULT_BRIGHTNESS=1200
export OF_USE_GREEN_LED=0
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

# -----------------------------------------------------------------------
# Tools & Features
export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# -----------------------------------------------------------------------
# Security / Encryption
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_USE_FBE_DECRYPTION=1
export OF_USE_METADATA_DECRYPTION=1
export OF_USE_INLINE_CRYPTO=1

# -----------------------------------------------------------------------
# Magisk / AVB Patch
export FOX_PATCH_VBMETA_FLAG=1
export FOX_USE_UPDATED_MAGISKBOOT=1
