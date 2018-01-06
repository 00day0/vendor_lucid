# Charger
ifeq ($(WITH_OZONE_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.ozone
endif
