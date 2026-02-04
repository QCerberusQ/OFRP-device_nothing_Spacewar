#
# vendorsetup.sh – Spacewar (Pure Vendor Boot / Optimized UI)
#

# -----------------------------------------------------------------------------
# Bash Safety Check
# -----------------------------------------------------------------------------
if [ -z "$BASH_SOURCE" ]; then
    echo "ERROR: This script requires bash."
    return 1
fi

export LC_ALL="C"

# -----------------------------------------------------------------------------
# Device Information
# -----------------------------------------------------------------------------
export FOX_BUILD_DEVICE="Spacewar"
export FOX_TARGET_DEVICES="Spacewar,spacewar"
export TARGET_DEVICE_ALT="Spacewar,spacewar"
export OF_MAINTAINER="QCerberusQ"
export FOX_BUILD_TYPE="Beta"

# -----------------------------------------------------------------------------
# ARCHITECTURE SETTINGS (PURE VENDOR BOOT)
# -----------------------------------------------------------------------------
# Bu satır, BoardConfig ve Device tree'deki tüm v4 ayarlarını tetikler.
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

# Kurulum ZIP'i hazırlanırken "vendor_boot" bölümüne kurulacağını belirtir.

# Versiyon etiketi
export FOX_VARIANT="BaR"

# -----------------------------------------------------------------------------
# Screen & UI Settings (Eski Dosyadan Optimize Edildi)
# -----------------------------------------------------------------------------
export OF_SCREEN_H=2400
export OF_SCREEN_W=1080
export OF_STATUS_H=115

# KRİTİK AYARLAR (Eski Çalışan Dosyadan):
# Sol taraftan 165 piksel boşluk bırakır (Kamera deliği için şart)
export OF_STATUS_INDENT_LEFT=165 
export OF_STATUS_INDENT_RIGHT=48

# Çentik Ayarları
export OF_HIDE_NOTCH=1
export OF_CLOCK_POS=0 # Saati sola alır

# Tema ve Parlaklık
export TW_THEME="portrait_hdpi"
export TW_MAX_BRIGHTNESS=2047
export TW_DEFAULT_BRIGHTNESS=1200
export OF_USE_GREEN_LED=0

# MIUI özelliklerini kapat (Temiz arayüz için eski dosyadan)
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

# -----------------------------------------------------------------------------
# Features & Tools (Senin Dosyandan - Gelişmiş Araçlar)
# -----------------------------------------------------------------------------
export FOX_USE_BASH_SHELL=1
#export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1

# Advanced Binaries (Yedekleme hızı için çok önemli)
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_FSCK_EROFS_BINARY=1

# -----------------------------------------------------------------------------
# Security & Encryption (Eski Dosyadan)
# -----------------------------------------------------------------------------
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_USE_FBE_DECRYPTION=1
export OF_USE_METADATA_DECRYPTION=1
export OF_FORCE_PREBUILT_KEYMASTER=1
export OF_USE_INLINE_CRYPTO=1
# -----------------------------------------------------------------------------
# Magisk & Boot Patching
# -----------------------------------------------------------------------------
# Bootloop önleyici VBMeta yaması
export FOX_PATCH_VBMETA_FLAG="1"
export FOX_USE_UPDATED_MAGISKBOOT=1

# -----------------------------------------------------------------------------
# A/B & Virtual AB
# -----------------------------------------------------------------------------
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_AB_DEVICE=1
