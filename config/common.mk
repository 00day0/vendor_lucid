include vendor/lucid/config/ProductConfigQcom.mk

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

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
    vendor/lucid/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lucid/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lucid/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

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
    ro.boot.vendor.overlay.theme=com.lucid.wellbeingconf;com.lucid.googleconf

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/lucid/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/lucid/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/lucid/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/lucid/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

#Support Vendors
PRODUCT_PACKAGES += \
    VendorSupportLib

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/lucid/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/lucid/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/lucid/overlay/common

# Packages
include vendor/lucid/config/packages.mk

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# Build nomenclature
LUCID_PLATFORM_VERSION := 10.0
LUCID_VERSION := $(LUCID_BUILD)-$(LUCID_PLATFORM_VERSION)-$(shell date -u +%Y%m%d)
