#!/usr/bin/env bash

# ========================================================================
# Copyright (c) 2020 Netcrest Technologies, LLC. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ========================================================================

SCRIPT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
# __DESKTOP_DIR is intentional. Do NOT change.
# It is manipulated for hazelcast-desktop during the build time. 
__DESKTOP_DIR=$SCRIPT_DIR
APP_DIR="$(dirname "$__DESKTOP_DIR")"
APPS_DIR="$(dirname "$APP_DIR")"
BASE_DIR=$PADOGRID_HOME/$PRODUCT
pushd  $BASE_DIR/bin_sh > /dev/null 2>&1
. $BASE_DIR/bin_sh/.addonenv.sh
popd > /dev/null 2>&1

APP_NAME="$(basename "$APP_DIR")"

# Need to reset SCRIPT_DIR. It has a different value due to the above calls. 
SCRIPT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

APP_ETC_DIR=$APP_DIR/etc
APP_LOG_DIR=$APP_DIR/log
if [ ! -d "$APP_LOG_DIR" ]; then
   mkdir -p "$APP_LOG_DIR"
fi

# Source in app specifics
. $APP_DIR/bin_sh/setenv.sh

# Log properties for lo4j2. The log file name is set in executable scripts.
# Do not use the add log. Use the desktop log instead.
#JAVA_OPT="$JAVA_OPT -Dhazelcast.logging.type=log4j2 \
#-Dlog4j.configurationFile=$APP_ETC_DIR/log4j2.properties \
#-DlogDir=$APP_DIR/log"
