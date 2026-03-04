#
# SPDX-License-Identifier: Apache-2.0
#
# OrangeFox Recovery Project
# Product makefile for Nothing Phone (1)
# Codename: Spacewar
# Recovery type: Vendor Boot (Header v3)
#

# -----------------------------------------------------------------------------
# 1. Base Android Configuration (CRITICAL)
# -----------------------------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# -----------------------------------------------------------------------------
# 2. Device Definitions
# -----------------------------------------------------------------------------
PRODUCT_RELEASE_NAME := Spacewar
DEVICE_PATH := device/nothing/$(PRODUCT_RELEASE_NAME)

# -----------------------------------------------------------------------------
# 3. Inherit Device Configuration (Önce base)
# -----------------------------------------------------------------------------
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# -----------------------------------------------------------------------------
# 4. Inherit Common TWRP / OrangeFox Configuration (Orta - override yapar)
# -----------------------------------------------------------------------------
$(call inherit-product, vendor/twrp/config/common.mk)

# -----------------------------------------------------------------------------
# 5. Inherit OrangeFox Config (SON - en yüksek öncelik)
# -----------------------------------------------------------------------------
# fox_Spacewar.mk'deki ayarlar common.mk'yi ezer
$(call inherit-product-if-exists, $(DEVICE_PATH)/fox_Spacewar.mk)

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
PRODUCT_GMS_CLIENTID_BASE := android-nothing
