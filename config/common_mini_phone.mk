# Inherit mini common Ozone stuff
$(call inherit-product, vendor/ozone/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/ozone/config/telephony.mk)
