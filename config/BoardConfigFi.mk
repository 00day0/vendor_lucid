ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/fi/config/BoardConfigQcom.mk
endif

include vendor/fi/config/BoardConfigSoong.mk
