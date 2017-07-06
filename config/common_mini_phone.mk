$(call inherit-product, vendor/ozone/config/common_mini.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/ozone/config/telephony.mk)
