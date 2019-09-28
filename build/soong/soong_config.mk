 # Insert new variables inside the Ozone structure
ozone_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"Ozone": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
