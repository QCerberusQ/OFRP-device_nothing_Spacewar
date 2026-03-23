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

# -----------------------------------------------------------------------------
# A/B OTA
# -----------------------------------------------------------------------------
ENABLE_VIRTUAL_AB := true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# -----------------------------------------------------------------------------
# Boot Control (NP1 Custom)
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service \
    libgptutils.nothing \
    bootctl

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

PRODUCT_PACKAGES += \
    snapuserd \
    liburing \
    libz \
    liblz4 \
    libsnapshot_cow

# -----------------------------------------------------------------------------
# Fastbootd
# -----------------------------------------------------------------------------
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
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# -----------------------------------------------------------------------------
# Health HAL
# -----------------------------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhealthd.lahaina

# -----------------------------------------------------------------------------
# Soong Namespaces
# -----------------------------------------------------------------------------
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# -----------------------------------------------------------------------------
# differentiate legacy 'sg' or 'bsg' framework
# -----------------------------------------------------------------------------
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# -----------------------------------------------------------------------------
# FUSE PASSTHROUGH
# -----------------------------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true
