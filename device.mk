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
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# -----------------------------------------------------------------------------
# Boot Control HAL (recovery-safe)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot-service.qti.recovery \
    bootctrl.lahaina.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# -----------------------------------------------------------------------------
# Soong namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# Update engine (A/B devices need this)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# -----------------------------------------------------------------------------
# Decryption stack (NO HAL SERVICES)
# -----------------------------------------------------------------------------
# Only binaries –
PRODUCT_PACKAGES += \
    vold \
    qcom_decrypt \
    qcom_decrypt_fbe \
    libvold_crypto

PRODUCT_PACKAGES += \
    android.system.keystore2

# -----------------------------------------------------------------------------
# Health HAL (safe)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhealthd.lahaina

# -----------------------------------------------------------------------------
# Display / Boot related libs required in recovery
# -----------------------------------------------------------------------------
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libboot_control_qti.so

# -----------------------------------------------------------------------------
# Recovery modules (userspace dependencies only)
# -----------------------------------------------------------------------------
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

# -----------------------------------------------------------------------------
# Properties
# -----------------------------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_verify_source_hash=true \
    ro.product.device=$(PRODUCT_RELEASE_NAME)

# Bunu MUTLAKA EKLE (Çünkü senin listede keystore2 yok):
RECOVERY_COPY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/keystore2:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/keystore2
# -----------------------------------------------------------------------------
# TW
# -----------------------------------------------------------------------------
TW_EXCLUDE_APEX := true

# -----------------------------------------------------------------------------
# VINTF
# -----------------------------------------------------------------------------
PRODUCT_ENFORCE_VINTF_MANIFEST := true
