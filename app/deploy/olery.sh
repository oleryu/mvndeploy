#!/bin/bash

#compile
#install

cmd=$1

PROJECT_DIR=/opt/wallet_root/wallet-sys
java "-Dmaven.multiModuleProjectDirectory=${PROJECT_DIR}" \
         "-Dmaven.home=${M2_HOME}" \
         "-Dclassworlds.conf=${M2_HOME}/bin/m2.conf" \
         -Dfile.encoding=UTF-8 \
         -classpath \
         "${M2_HOME}/boot/plexus-classworlds-2.5.2.jar" org.codehaus.classworlds.Launcher \
         -s "${M2_HOME}/conf/settings.xml" \
          "-Dmaven.repo.local=/opt/apache-maven-3.5.4/repository" $cmd