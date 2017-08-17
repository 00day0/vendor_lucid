# Inherit common Ozone stuff
$(call inherit-product, vendor/ozone/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Ozone LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/ozone/overlay/dictionaries

$(call inherit-product, vendor/ozone/config/telephony.mk)
