ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/ozone/config/BoardConfigQcom.mk
endif

include vendor/ozone/config/BoardConfigSoong.mk
