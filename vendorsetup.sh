#
# vendorsetup.sh – Spacewar (Boot Image Based / Header v3)
#

if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: This script requires bash."
    return 1
fi

export LC_ALL="C"
export TARGET_ARCH="arm64"
export ALLOW_MISSING_DEPENDENCIES=true

# -----------------------------------------------------------------------
# Device & Build Info
# -----------------------------------------------------------------------
export FOX_BUILD_DEVICE="Spacewar"
export FOX_TARGET_DEVICES="Spacewar,spacewar"
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Stable"
export FOX_VANILLA_BUILD=1

# -----------------------------------------------------------------------
# A/B & Virtual AB
# -----------------------------------------------------------------------
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1

# -----------------------------------------------------------------------
# Storage & Format Rescuers (SAF & STABİL)
# -----------------------------------------------------------------------
export OF_USE_DMCTL=1
export OF_FBE_METADATA_MOUNT_IGNORE=1
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
export OF_RUN_POST_FORMAT_PROCESS=1
export OF_NO_REFLASH_CURRENT_ORANGEFOX=1
export OF_NO_RELOAD_AFTER_DECRYPTION=1
export TW_PREPARE_DATA_MEDIA_EARLY=1

# -----------------------------------------------------------------------
# Tools & Features
# -----------------------------------------------------------------------
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
#export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1
export FOX_DELETE_INITD_ADDON=1
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_ALLOW_EARLY_SETTINGS_LOAD=1
export OF_LOOP_DEVICE_ERRORS_TO_LOG=1
export OF_DONT_KEEP_LOG_HISTORY=1
export FOX_USE_GREP_BINARY=1
export FOX_USE_DATE_BINARY=1
export FOX_USE_PATCHELF_BINARY=1

# -----------------------------------------------------------------------
# Binaries & Compression
# -----------------------------------------------------------------------
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export OF_USE_LZ4_COMPRESSION=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# -----------------------------------------------------------------------
# Security / Encryption
# -----------------------------------------------------------------------
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_USE_FBE_DECRYPTION=1
export OF_USE_METADATA_DECRYPTION=1
export OF_USE_INLINE_CRYPTO=1

# -----------------------------------------------------------------------
# Magisk / AVB Patch & Root (Yarış Durumu Önlendi)
# -----------------------------------------------------------------------
export FOX_USE_UPDATED_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
