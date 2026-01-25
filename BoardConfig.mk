#
# Copyright (C) 2021 The TWRP Open Source Project
#

ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true

DEVICE_PATH := device/nothing/Spacewar

# -----------------------------------------------------------------------------
# Architecture
# -----------------------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_VARIANT := cortex-a76

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# -----------------------------------------------------------------------------
# Assert
# -----------------------------------------------------------------------------
TARGET_OTA_ASSERT_DEVICE := Spacewar

# -----------------------------------------------------------------------------
# A/B
# -----------------------------------------------------------------------------
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

# -----------------------------------------------------------------------------
# Platform
# -----------------------------------------------------------------------------
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := lahaina

# -----------------------------------------------------------------------------
# Kernel (PREBUILT – boot.img)
# -----------------------------------------------------------------------------
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
TARGET_FORCE_PREBUILT_KERNEL := true

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# -----------------------------------------------------------------------------
# Boot image header
# -----------------------------------------------------------------------------
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version 4

# -----------------------------------------------------------------------------
# Kernel cmdline (CLEAN – no permissive)
# -----------------------------------------------------------------------------
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=0

# -----------------------------------------------------------------------------
# Ramdisk
# -----------------------------------------------------------------------------
BOARD_RAMDISK_USE_LZ4 := true

# -----------------------------------------------------------------------------
# Metadata
# -----------------------------------------------------------------------------
BOARD_USES_METADATA_PARTITION := true

# -----------------------------------------------------------------------------
# File systems
# -----------------------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_VENDOR := vendor
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

# -----------------------------------------------------------------------------
# Recovery
# -----------------------------------------------------------------------------
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# -----------------------------------------------------------------------------
# AVB
# -----------------------------------------------------------------------------
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# -----------------------------------------------------------------------------
# Crypto / FBE
# -----------------------------------------------------------------------------
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 1
TW_PREPARE_DATA_MEDIA_EARLY := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# -----------------------------------------------------------------------------
# Android 14 decryption spoof
# -----------------------------------------------------------------------------
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# -----------------------------------------------------------------------------
# OrangeFox / TWRP UI
# -----------------------------------------------------------------------------
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true

TW_INPUT_BLACKLIST := "hbtp_vm"

TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200

TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_EXCLUDE_TWRPAPP := true

TW_OVERRIDE_SYSTEM_PROPS := \
    ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint; \
    ro.build.version.incremental;ro.product.device=ro.product.system.device; \
    ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name

TW_Y_OFFSET := 20
TW_H_OFFSET := -20
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"

# -----------------------------------------------------------------------------
# Haptics
# -----------------------------------------------------------------------------
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SKIP_ADDITIONAL_FSTAB := true
