#
# Copyright (C) 2021 The TWRP Open Source Project
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

LOCAL_PATH := device/nothing/Spacewar

PRODUCT_SHIPPING_API_LEVEL := 31

PRODUCT_TARGET_VNDK_VERSION := 31
TW_FRAMERATE := 120

# A/B Configuration
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# ---------------------------------------------------------
# BOOT CONTROL HAL (BİZİM DÜZELTTİĞİMİZ KISIM - 1.2)
# ---------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot-service.qti.recovery \
    bootctrl.lahaina.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# ---------------------------------------------------------
# Kütüphaneler (libandroidicu Düzeltmesi)
# ---------------------------------------------------------
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

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# VINTF
#PRODUCT_ENFORCE_VINTF_MANIFEST := true

PRODUCT_PROPERTY_OVERRIDES += \
	ro.virtual_ab.skip_verify_source_hash=true

