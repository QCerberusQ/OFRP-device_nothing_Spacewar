#
# SPDX-License-Identifier: Apache-2.0
#

# -----------------------------------------------------------------------------
# 1. Base Android Configuration
# -----------------------------------------------------------------------------
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
# 4. Inherit Common TWRP / OrangeFox Configuration
# -----------------------------------------------------------------------------
$(call inherit-product, vendor/twrp/config/common.mk)

# -----------------------------------------------------------------------------
# 5. Inherit OrangeFox Config
# -----------------------------------------------------------------------------
$(call inherit-product, $(DEVICE_PATH)/fox_Spacewar.mk)

# -----------------------------------------------------------------------------
# 6. Device Identifiers (MUST be last)
# -----------------------------------------------------------------------------
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := twrp_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
PRODUCT_GMS_CLIENTID_BASE := android-nothing
