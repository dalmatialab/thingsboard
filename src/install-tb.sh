#!/bin/bash
#
# Copyright © 2016-2019 The Thingsboard Authors
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
#

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --loadDemo)
    LOAD_DEMO=true
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ "$LOAD_DEMO" == "true" ]; then
    loadDemo=true
else
    loadDemo=false
fi

CONF_FOLDER="/usr/share/thingsboard/conf"
jarfile=/usr/share/thingsboard/bin/thingsboard.jar
configfile=thingsboard.conf
upgradeversion=${DATA_FOLDER}/.upgradeversion

source "${CONF_FOLDER}/${configfile}"

echo "Starting ThingsBoard installation ..."

java -cp ${jarfile} $JAVA_OPTS -Dloader.main=org.thingsboard.server.ThingsboardInstallApplication \
                    -Dinstall.load_demo=${loadDemo} \
                    -Dspring.jpa.hibernate.ddl-auto=none \
                    -Dinstall.upgrade=false \
                    -Dlogging.config=/usr/share/thingsboard/bin/install/logback.xml \
                    org.springframework.boot.loader.PropertiesLauncher

echo "2.3.1" > ${upgradeversion}
