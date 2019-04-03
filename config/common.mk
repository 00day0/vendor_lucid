PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/fi/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/fi/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.boot.vendor.overlay.theme=com.ozone.wellbeingconf

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/fi/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/fi/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

#Support Vendors
PRODUCT_PACKAGES += \
    VendorSupportLib

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/fi/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/fi/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/fi/overlay/common

# Accents
include vendor/fi/config/accents.mk

# Themes
include vendor/fi/config/themes.mk

# Packages
include vendor/fi/config/packages.mk

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif
