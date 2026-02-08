#
# Copyright (C) 2021 The TWRP Open Source Project
# Nothing Phone (1) / Spacewar - FINAL STABLE DEVICE.MK
#

# -----------------------------------------------------------------------------
# Base inherits
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# -----------------------------------------------------------------------------
# Device basics
# -----------------------------------------------------------------------------
LOCAL_PATH := device/nothing/Spacewar

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

TW_FRAMERATE := 120

# -----------------------------------------------------------------------------
# A/B OTA
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
    vendor \
    vendor_dlkm \
    vendor_boot

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# -----------------------------------------------------------------------------
# Boot Control (NP1 Custom)
# -----------------------------------------------------------------------------
# Boot kontrolü için bunlar ŞART, ama gereksiz update_engine servislerini sildik.
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery \
    libgptutils.nothing \
    bootctl \
    otapreopt_script

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
# Mock (Taklit) HAL silindi. Sadece binary kalsın.
PRODUCT_PACKAGES += \
    fastbootd

# -----------------------------------------------------------------------------
# Crypto / Decryption
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.system.keystore2 \
    qcom_decrypt \
    qcom_decrypt_fbe

# -----------------------------------------------------------------------------
# Recovery Libraries & Display
# -----------------------------------------------------------------------------
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/switch_encryption.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/switch_encryption.sh

# -----------------------------------------------------------------------------
# Health HAL
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# -----------------------------------------------------------------------------
# Soong Namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# TW
# -----------------------------------------------------------------------------
TW_EXCLUDE_APEX := true

# -----------------------------------------------------------------------------
# VINTF
# -----------------------------------------------------------------------------
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# -----------------------------------------------------------------------------
# SKIP VERIFY GAPPS
# -----------------------------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
	ro.virtual_ab.skip_verify_source_hash=true
