# Copyright (C) 2015 The CyanogenMod Project
#           (C) 2017 The Ozone Project
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

OZONE_SRC_API_DIR := $(TOPDIR)prebuilts/ozone-sdk/api
INTERNAL_OZONE_PLATFORM_API_FILE := $(TARGET_OUT_COMMON_INTERMEDIATES)/PACKAGING/ozone_public_api.txt
INTERNAL_OZONE_PLATFORM_REMOVED_API_FILE := $(TARGET_OUT_COMMON_INTERMEDIATES)/PACKAGING/ozone_removed.txt
FRAMEWORK_OZONE_PLATFORM_API_FILE := $(TOPDIR)ozone-sdk/api/ozone_current.txt
FRAMEWORK_OZONE_PLATFORM_REMOVED_API_FILE := $(TOPDIR)ozone-sdk/api/ozone_removed.txt
FRAMEWORK_OZONE_API_NEEDS_UPDATE_TEXT := $(TOPDIR)vendor/ozone/build/core/apicheck_msg_current.txt

BUILD_MAVEN_PREBUILT := $(TOP)/vendor/ozone/build/core/maven_artifact.mk
PUBLISH_MAVEN_PREBUILT := $(TOP)/vendor/ozone/build/core/maven_artifact_publish.mk

BUILD_HTTP_PREBUILT := $(TOP)/vendor/ozone/build/core/http_prebuilt.mk
