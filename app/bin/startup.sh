#!/bin/bash


PROJECT_DIR=/opt/wallet_root/ethobserver/app

target_line=`ls -1 $PROJECT_DIR/lib/*.jar|sed 's/\(.*\)-\([0-9]\.[0-9]\.[0-9]\.[0-9]\)-\(.*\).jar/\1 \2 \3/g'`


args=($target_line)

jar_name=${args[0]}

jar_name=${jar_name##*/}
jar_ver=${args[1]}
jar_type=${args[2]}



nohup java -Dserver.port=8996 -jar ../lib/${jar_name}-${jar_ver}-${jar_type}.jar --spring.config.location=file:${PROJECT_DIR}/app/conf/application-${jar_type}.properties > ../logs/${jar_name}.log 2>&1 &