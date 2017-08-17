PRODUCT_BRAND ?= Ozone

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/ozone/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/ozone/prebuilt/common/bin/50-ozone.sh:system/addon.d/50-ozone.sh \
    vendor/ozone/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/ozone/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Ozone-specific init file
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/etc/init.local.rc:root/init.ozone.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/ozone/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Ozone!
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Include Ozone audio files
include vendor/ozone/config/ozone_audio.mk

# Theme engine
include vendor/ozone/config/themes_common.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/ozone/config/cmsdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/ozone/config/twrp.mk
endif

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
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom Ozone packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    CMUpdater \
    OzoneSetupWizard \
    Eleven \
    ExactCalculator \
    Jelly \
    LiveLockScreenService \
    LockClock \
    Trebuchet \
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
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_OZONE_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    ozone_charger_res_images \
    font_log.png \
    libhealthd.ozone
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

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

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
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
        OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
    else
        OZONE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(OZONE_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(OZONE_BUILDTYPE)$(OZONE_EXTRAVERSION)-$(OZONE_BUILD)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ozone.version=$(OZONE_VERSION) \
    ro.ozone.releasetype=$(OZONE_BUILDTYPE) \
    ro.modversion=$(OZONE_VERSION) \
    ro.ozonelegal.url=https://ozoneos.org/legal

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

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ozone.display.version=$(OZONE_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/ozone/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
