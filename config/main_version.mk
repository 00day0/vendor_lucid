# Ozone System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ozone.version=$(OZONE_VERSION) \
    ro.ozone.releasetype=$(OZONE_BUILDTYPE) \
    ro.ozone.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(OZONE_VERSION) \
    ro.ozonelegal.url=https://ozoneos.org/legal

# Ozone Platform Display Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ozone.display.version=$(OZONE_DISPLAY_VERSION)

# Ozone Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ozone.build.version.plat.sdk=$(OZONE_PLATFORM_SDK_VERSION)

# Ozone Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ozone.build.version.plat.rev=$(OZONE_PLATFORM_REV)
