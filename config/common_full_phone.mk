# Inherit common stuff
$(call inherit-product, vendor/fi/config/common.mk)
# World APN list
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml
# World SPN overrides list
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/etc/spn-conf.xml:system/etc/spn-conf.xml
# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml
# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk
# Boot animations
$(call inherit-product-if-exists, vendor/fi/products/bootanimation.mk)
