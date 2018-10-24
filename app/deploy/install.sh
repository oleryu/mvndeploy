#/bin/bash


AP_BOOT_DIR=/opt/wallet_root/ethobserver

AP_MAIN_POM=${AP_BOOT_DIR}/pom.xml

PROJECT_DIR=/opt/wallet_root/ethobserver
DESPOLY_ROOT=${PROJECT_DIR}/app/deploy

finalName=`cat $AP_MAIN_POM|grep "<finalName>"|sed 's/.*<finalName>\(.*\).*.${deploy.version}.*<\/finalName>/\1/g'`

echo ">"$finalName

#-------------------------------------------------------------------
#<deploy.type>dev</deploy.type>
desploy_type=`${DESPOLY_ROOT}/prs.sh $AP_MAIN_POM|grep "<activeByDefault>true</activeByDefault>"|sed 's/.*<deploy\.type>\(.*\)<\/deploy\.type><deploy\.version>\(.*\)<\/deploy\.version>.*<filter>\(.*\)<\/filter>.*/\1 \2 \3/g'`
echo $desploy_type
#------------------------------------------------------------------

args=($desploy_type)

select_type=${args[0]}
select_version=${args[1]}
select_conf=${args[2]}

cd ${PROJECT_DIR}


${DESPOLY_ROOT}/olery.sh clean
${DESPOLY_ROOT}/olery.sh compile
${DESPOLY_ROOT}/olery.sh install


cur_time=`date "+%Y%m%d%H%M%S"`
#if [ -f "${PROJECT_DIR}/app/lib/${finalName}.jar" ]
#then
    if [ ! -d "${PROJECT_DIR}/app/lib/bak" ]
    then
       mkdir ${PROJECT_DIR}/app/lib/bak

    fi

    ls -1 ${PROJECT_DIR}/app/lib|grep ${finalName}|while read line
    do
        mv ${PROJECT_DIR}/app/lib/$line ${PROJECT_DIR}/app/lib/bak/$cur_time"_"$line
    done
#fi


#if [ -f "${PROJECT_DIR}/app/conf/${select_conf}" ]
#then
    if [ ! -d "${PROJECT_DIR}/app/conf/bak" ]
    then
       mkdir ${PROJECT_DIR}/app/conf/bak

    fi
    ls -1 ${PROJECT_DIR}/app/conf|grep application|grep properties|while read line
    do
        mv ${PROJECT_DIR}/app/conf/$line ${PROJECT_DIR}/app/conf/bak/$cur_time"_"$line
    done
#fi

cp ${PROJECT_DIR}/target/${finalName}-${select_version}-${select_type}.jar ${PROJECT_DIR}/app/lib/

cp ${PROJECT_DIR}/${select_conf} ${PROJECT_DIR}/app/conf/${select_conf}