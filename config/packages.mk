# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

PRODUCT_COPY_FILES += \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-Regular.ttf:system/fonts/GoogleSans-Regular.ttf \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-Medium.ttf:system/fonts/GoogleSans-Medium.ttf \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-MediumItalic.ttf:system/fonts/GoogleSans-MediumItalic.ttf \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-Italic.ttf:system/fonts/GoogleSans-Italic.ttf \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-Bold.ttf:system/fonts/GoogleSans-Bold.ttf \
   vendor/lucid/prebuilt/common/fonts/GoogleSans-BoldItalic.ttf:system/fonts/GoogleSans-BoldItalic.ttf

ADDITIONAL_FONTS_FILE := vendor/lucid/prebuilt/common/fonts/google-sans.xml
