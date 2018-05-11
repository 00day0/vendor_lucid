# Permissions for ozone sdk services
PRODUCT_COPY_FILES += \
    vendor/ozone/config/permissions/org.ozone.audio.xml:system/etc/permissions/org.ozone.audio.xml \
    vendor/ozone/config/permissions/org.ozone.livedisplay.xml:system/etc/permissions/org.ozone.livedisplay.xml \
    vendor/ozone/config/permissions/org.ozone.performance.xml:system/etc/permissions/org.ozone.performance.xml \
    vendor/ozone/config/permissions/org.ozone.profiles.xml:system/etc/permissions/org.ozone.profiles.xml \
    vendor/ozone/config/permissions/org.ozone.statusbar.xml:system/etc/permissions/org.ozone.statusbar.xml \
    vendor/ozone/config/permissions/org.ozone.telephony.xml:system/etc/permissions/org.ozone.telephony.xml \
    vendor/ozone/config/permissions/org.ozone.weather.xml:system/etc/permissions/org.ozone.weather.xml

# CM Platform Library
PRODUCT_PACKAGES += \
    org.ozone.platform-res \
    org.ozone.platform \
    org.ozone.platform.xml

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.ozone.hardware \
    org.ozone.hardware.xml

# JNI Libraries
PRODUCT_PACKAGES += \
    libozone-sdk_platform_jni

ifndef OZONE_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  OZONE_PLATFORM_SDK_VERSION := 8
endif

ifndef OZONE_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each OZONE_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  OZONE_PLATFORM_REV := 0
endif
