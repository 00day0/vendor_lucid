# Inherit common Ozone stuff
$(call inherit-product, vendor/ozone/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
