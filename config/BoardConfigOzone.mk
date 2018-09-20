include vendor/lucid/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/lucid/config/BoardConfigQcom.mk
endif

include vendor/lucid/config/BoardConfigSoong.mk
