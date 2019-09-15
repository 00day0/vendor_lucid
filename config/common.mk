# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= Ozone

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/ozone/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/ozone/prebuilt/common/bin/50-ozone.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-ozone.sh \
    vendor/ozone/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/ozone/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/ozone/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

# Ozone-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/ozone-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/ozone-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner \
    vendor/ozone/prebuilt/common/bin/sysinit:$(TARGET_COPY_OUT_SYSTEM)/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/etc/init.d/90userinit:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/90userinit
endif

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/ozone/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Ozone!
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/org.ozone.android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.ozoneos.android.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Include AOSP audio files
include vendor/ozone/config/aosp_audio.mk

ifneq ($(TARGET_DISABLE_OZONE_SDK), true)
# Ozone SDK
include vendor/ozone/config/ozone_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/ozone/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required Ozone packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Development \
    Profiles \
    WeatherManagerService

# Optional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Custom Ozone packages
PRODUCT_PACKAGES += \
    AudioFX \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in Ozone
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifneq ($(WITH_OZONE_CHARGER),false)
PRODUCT_PACKAGES += \
    ozone_charger_res_images \
    font_log.png \
    libhealthd.ozone
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/ozone/overlay/common

PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    OZONE_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    OZONE_VERSION_MAINTENANCE := 0
endif

# Set OZONE_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef OZONE_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "OZONE_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^OZONE_||g')
        OZONE_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(OZONE_BUILDTYPE)),)
    OZONE_BUILDTYPE :=
endif

ifdef OZONE_BUILDTYPE
    ifneq ($(OZONE_BUILDTYPE), SNAPSHOT)
        ifdef OZONE_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            OZONE_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from OZONE_EXTRAVERSION
            OZONE_EXTRAVERSION := $(shell echo $(OZONE_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to OZONE_EXTRAVERSION
            OZONE_EXTRAVERSION := -$(OZONE_EXTRAVERSION)
        endif
    else
        ifndef OZONE_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            OZONE_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from OZONE_EXTRAVERSION
            OZONE_EXTRAVERSION := $(shell echo $(OZONE_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to OZONE_EXTRAVERSION
            OZONE_EXTRAVERSION := -$(OZONE_EXTRAVERSION)
        endif
    endif
else
    # If OZONE_BUILDTYPE is not defined, set to UNOFFICIAL
    OZONE_BUILDTYPE := UNOFFICIAL
    OZONE_EXTRAVERSION :=
endif

ifeq ($(OZONE_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        OZONE_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(OZONE_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OZONE_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(OZONE_VERSION_MAINTENANCE),0)
                OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(OZONE_BUILD)
            else
                OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(OZONE_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(OZONE_BUILD)
            endif
        else
            OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OZONE_BUILD)
        endif
    endif
else
    ifeq ($(OZONE_VERSION_MAINTENANCE),0)
        ifeq ($(OZONE_BUILDTYPE), UNOFFICIAL)
            OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d_%H%M%S)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
        else
            OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
        endif
    else
        ifeq ($(OZONE_BUILDTYPE), UNOFFICIAL)
            OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(OZONE_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d_%H%M%S)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
        else
            OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(OZONE_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
        endif
    endif
endif

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/ozone/build/target/product/security/ozone

-include vendor/ozone-priv/keys/keys.mk

OZONE_DISPLAY_VERSION := $(OZONE_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(OZONE_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(OZONE_EXTRAVERSION),)
                # Remove leading dash from OZONE_EXTRAVERSION
                OZONE_EXTRAVERSION := $(shell echo $(OZONE_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(OZONE_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(OZONE_VERSION_MAINTENANCE),0)
            OZONE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(OZONE_BUILD)
        else
            OZONE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(OZONE_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(OZONE_BUILD)
        endif
    endif
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/ozone/config/partner_gms.mk
