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
ENABLE_VIRTUAL_AB := true

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

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# -----------------------------------------------------------------------------
# Boot Control (NP1 Custom)
# -----------------------------------------------------------------------------
# Boot kontrolü için bunlar ŞART, ama gereksiz update_engine servislerini sildik.
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery \
    libgptutils.nothing \
    bootctl

PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# f2fs ve ext4 araçlarını zorla içeri sok
PRODUCT_PACKAGES += \
    mkfs.f2fs \
    fsck.f2fs \
    mke2fs \
    tune2fs \
    libf2fs

TARGET_RECOVERY_DEVICE_MODULES += \
    mkfs.f2fs \
    fsck.f2fs \
    mke2fs \
    tune2fs \
    libf2fs

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
    android.hidl.allocator@1.0 \
    android.hidl.memory@1.0 \
    android.hidl.memory.token@1.0 \
    libdmabufheap \
    libhidlmemory \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.allocator@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory.token@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdmabufheap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidlmemory.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so


# -----------------------------------------------------------------------------
# Health HAL
# -----------------------------------------------------------------------------
# Health HAL
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
# namespace definition for librecovery_updater
# differentiate legacy 'sg' or 'bsg' framework
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# Support to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

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
#PRODUCT_PROPERTY_OVERRIDES += \
#	ro.virtual_ab.skip_verify_source_hash=true

# -----------------------------------------------------------------------------
# SKIP SNAPSHOT
# -----------------------------------------------------------------------------
# skip some snapshot stuff in update_engine
#PRODUCT_PROPERTY_OVERRIDES += \
#	ro.virtual_ab.skip_snapshot_creation=true
