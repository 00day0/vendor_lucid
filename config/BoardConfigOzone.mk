# Charger
ifneq ($(WITH_OZONE_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.ozone
endif
