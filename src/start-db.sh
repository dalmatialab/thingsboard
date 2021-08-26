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

until nmap $POSTGRESQL_HOST -p $POSTGRESQL_PORT | grep "$POSTGRESQL_PORT/tcp open"
do
  echo "Wait for POSTGRESQL db to start..."
  sleep 5
done


PGPASSWORD=$SPRING_DATASOURCE_PASSWORD psql -h  $POSTGRESQL_HOST  -p $POSTGRESQL_PORT -U $SPRING_DATASOURCE_USERNAME -c "CREATE DATABASE thingsboard"

