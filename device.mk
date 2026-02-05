#
# Copyright (C) 2021 The TWRP Open Source Project
# Nothing Phone (1) / Spacewar - Optimized Device Tree
#

#$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

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
# BOOT CONTROL HAL 1.2 (Nothing Phone 1 Orijinal Yapısı)
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
# Kütüphaneler ve Display Config
# ---------------------------------------------------------
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

# ---------------------------------------------------------
# CRITICAL FIX: Boot HAL Crash Önleyici
# ---------------------------------------------------------
# Boot HAL 1.2'nin çalışması için bu kütüphaneler recovery içine taşınmalı
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libboot_control_qti.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libbase.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libc++.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so

# Decryption (Şifre Çözme)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Health HAL (Standart ve Güvenli Olan)
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhealthd.lahaina

# Property Overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.virtual_ab.skip_verify_source_hash=true \
    ro.product.device=$(PRODUCT_RELEASE_NAME)

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1-impl \
    android.hardware.keymaster@4.1-service

# vold crypto
PRODUCT_PACKAGES += \
    vold \
    libvold_crypto

# ---------------------------------------------------------
# Recovery’ye taşınması gereken ek bileşenler
# ---------------------------------------------------------

# vold ve qcom_decrypt ikincil kütüphane/binary
RECOVERY_COPY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/vold \
    $(TARGET_OUT_EXECUTABLES)/qcom_decrypt \
    $(TARGET_OUT_EXECUTABLES)/qcom_decrypt_fbe

# keymaster + gatekeeper libleri
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libvold_crypto.so \

