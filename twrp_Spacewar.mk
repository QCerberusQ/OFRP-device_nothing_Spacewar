# Inherit from minimal recovery bases
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Device
$(call inherit-product, device/nothing/Spacewar/device.mk)

# OrangeFox common
$(call inherit-product, vendor/twrp/config/common.mk)

# Identifiers
PRODUCT_DEVICE := Spacewar
PRODUCT_NAME := twrp_Spacewar
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing
