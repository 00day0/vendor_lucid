# Charger
ifeq ($(WITH_OZONE_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.ozone
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/ozone/config/BoardConfigQcom.mk
endif
