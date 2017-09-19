#
# Copyright (C) 2010 The Android Open Source Project
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Makefile for producing ozone sdk coverage reports.
# Run "make ozone-sdk-test-coverage" in the $ANDROID_BUILD_TOP directory.

ozone_sdk_api_coverage_exe := $(HOST_OUT_EXECUTABLES)/ozone-sdk-api-coverage
dexdeps_exe := $(HOST_OUT_EXECUTABLES)/dexdeps

coverage_out := $(HOST_OUT)/ozone-sdk-api-coverage

api_text_description := ozone-sdk/api/ozone_current.txt
api_xml_description := $(coverage_out)/api.xml
$(api_xml_description) : $(api_text_description) $(APICHECK)
	$(hide) echo "Converting API file to XML: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) $(APICHECK_COMMAND) -convert2xml $< $@

ozone-sdk-test-coverage-report := $(coverage_out)/ozone-sdk-test-coverage.html

ozone_sdk_tests_apk := $(call intermediates-dir-for,APPS,CMPlatformTests)/package.apk
ozonesettingsprovider_tests_apk := $(call intermediates-dir-for,APPS,OzoneSettingsProviderTests)/package.apk
ozone_sdk_api_coverage_dependencies := $(ozone_sdk_api_coverage_exe) $(dexdeps_exe) $(api_xml_description)

$(ozone-sdk-test-coverage-report): PRIVATE_TEST_CASES := $(ozone_sdk_tests_apk) $(ozonesettingsprovider_tests_apk)
$(ozone-sdk-test-coverage-report): PRIVATE_OZONE_SDK_API_COVERAGE_EXE := $(ozone_sdk_api_coverage_exe)
$(ozone-sdk-test-coverage-report): PRIVATE_DEXDEPS_EXE := $(dexdeps_exe)
$(ozone-sdk-test-coverage-report): PRIVATE_API_XML_DESC := $(api_xml_description)
$(ozone-sdk-test-coverage-report): $(ozone_sdk_tests_apk) $(ozonesettingsprovider_tests_apk) $(ozone_sdk_api_coverage_dependencies) | $(ACP)
	$(call generate-ozone-coverage-report,"OZONE-SDK API Coverage Report",\
			$(PRIVATE_TEST_CASES),html)

.PHONY: ozone-sdk-test-coverage
ozone-sdk-test-coverage : $(ozone-sdk-test-coverage-report)

# Put the test coverage report in the dist dir if "ozone-sdk" is among the build goals.
ifneq ($(filter ozone-sdk, $(MAKECMDGOALS)),)
  $(call dist-for-goals, ozone-sdk, $(ozone-sdk-test-coverage-report):ozone-sdk-test-coverage-report.html)
endif

# Arguments;
#  1 - Name of the report printed out on the screen
#  2 - List of apk files that will be scanned to generate the report
#  3 - Format of the report
define generate-ozone-coverage-report
	$(hide) mkdir -p $(dir $@)
	$(hide) $(PRIVATE_OZONE_SDK_API_COVERAGE_EXE) -d $(PRIVATE_DEXDEPS_EXE) -a $(PRIVATE_API_XML_DESC) -f $(3) -o $@ $(2) -cm
	@ echo $(1): file://$@
endef

# Reset temp vars
ozone_sdk_api_coverage_dependencies :=
ozone-sdk-combined-coverage-report :=
ozone-sdk-combined-xml-coverage-report :=
ozone-sdk-verifier-coverage-report :=
ozone-sdk-test-coverage-report :=
api_xml_description :=
api_text_description :=
coverage_out :=
dexdeps_exe :=
ozone_sdk_api_coverage_exe :=
ozone_sdk_verifier_apk :=
android_ozone_sdk_zip :=
