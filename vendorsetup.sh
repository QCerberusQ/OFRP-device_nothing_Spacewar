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
export FOX_BUILD_TYPE="Stable"
export FOX_VARIANT="BaR"

# -----------------------------------------------------------------------
# Install Target (critical for bootimage-based recovery)
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

# -----------------------------------------------------------------------
# A/B & Virtual AB
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1


# -------------------------------------------------------------------
# Pong’dan alınan faydalı stabilite ayarları
# -------------------------------------------------------------------
# Decryption sırasında metadata/partition hatalarını takma
export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
export OF_FBE_METADATA_MOUNT_IGNORE=1

# Uyum kontrol hataları yerine devam et
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1

# AVB 2.0 yaması (genelde gerekli)
export OF_PATCH_AVB20=1

# Manuel flash OTA hatalarından kurtul
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

# Format sonrası ek temizlik süreci
export OF_RUN_POST_FORMAT_PROCESS=1
export FOX_RESET_SETTINGS=1
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
export FOX_ASH_IS_BASH=1
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

export FOX_USE_ZIP_BINARY=1
export FOX_REPLACE_TOOLBOX_GETPROP=1

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
