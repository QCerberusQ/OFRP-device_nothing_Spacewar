#
# SPDX-License-Identifier: Apache-2.0
#
# OrangeFox Recovery Project
# Product makefile for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: Pure Vendor Boot (Header v4)
#

# -----------------------------------------------------------------------------
# 1. Base Android Configuration (CRITICAL - ESKİ DOSYADAN ALINDI)
# -----------------------------------------------------------------------------
# Bu iki satır olmadan sistem mimariyi tanıyamaz.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# -----------------------------------------------------------------------------
# 2. Device Definitions
# -----------------------------------------------------------------------------
PRODUCT_RELEASE_NAME := Spacewar
DEVICE_PATH := device/nothing/$(PRODUCT_RELEASE_NAME)

# -----------------------------------------------------------------------------
# 3. Inherit Device Configuration
# -----------------------------------------------------------------------------
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# -----------------------------------------------------------------------------
# 4. Optional OrangeFox Config
# -----------------------------------------------------------------------------
# Eğer fox_spacewar.mk varsa onu da dahil et (özelleştirmeler için)
$(call inherit-product-if-exists, $(DEVICE_PATH)/fox_Spacewar.mk)

# -----------------------------------------------------------------------------
# 5. Inherit Common TWRP / OrangeFox Configuration
# -----------------------------------------------------------------------------
$(call inherit-product, vendor/twrp/config/common.mk)

# -----------------------------------------------------------------------------
# 6. Build Sanity
# -----------------------------------------------------------------------------
BUILD_BROKEN_ARTIFACT_PATH_REQUIREMENTS := true

# -----------------------------------------------------------------------------
# 7. Device Identifiers (MUST be last)
# -----------------------------------------------------------------------------
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := twrp_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
