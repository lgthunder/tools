#!/usr/bin/env bash

# hotfixConfig [git-branch or tag] [Reuse mapping] [build]
# 三个参数，分别为:
# $1 必填，mapping文件的所在的branch名或者tag
# $2 选填，是否复用mapping.txt，默认每次构建都删除，从${1}拉取，传true则用已有的mapping
# $3 选填，是否构建，默认不构建，传入true，进行Release构建
root=`pwd`
temMappingDir=${root}/map
proguardPath=${root}/app/proguard-rules.pro
localMappingPath=${root}/app/mapping.txt
branch=$1
build=$2
gitAddress=http://leiting%40021.com:05010501@gitlab.shwlops.com/zoububaoandroid/zoububao.git

deleteTempMap() {
    if [[ -d ${temMappingDir} ]]; then
        echo "============delete ${temMappingDir}"
        rm -rf map/.git
        rm -r ${temMappingDir}
    else
        return 0
    fi
    return 0
}

pullMapping() {
    #获取mapping文件
    baseMappingPath=${temMappingDir}/app/mapping.txt

    deleteTempMap
    mkdir ${temMappingDir}
    cd ${temMappingDir}
    echo "=========pull mapping from ${branch}"
    git init
    git remote add origin ${gitAddress}
    git config core.sparsecheckout true
    echo "app/mapping.txt" >> .git/info/sparse-checkout
    git pull origin ${branch}
    cd ${root}
    echo "=========copy mapping from ${baseMappingPath} to ${root}/app/ "
    cp ${baseMappingPath} ${root}/app/
}

if [[ ! -n "$1" ]]; then
    echo "error:  branch or tag is empty"
    exit 1
fi

if [[ ! -f ${localMappingPath} ]]; then
    echo "${localMappingPath} not exist ,  pull that"
    pullMapping
elif [[ $2 == false ]]|| [[ ! -n "$2" ]]; then
    echo "${localMappingPath} exist , delete  and  pull"
    rm -f ${localMappingPath}
    pullMapping
else
    echo "${localMappingPath} exist go on "
fi

if [[ ! -f ${localMappingPath} ]]; then
    # pull mapping.txt 失败检查log
    echo "error failure to pull ${localMappingPath} check log"
    exit 1
fi

echo "==========modify ${proguardPath}"
sed -i.bak s#'\#-applymapping mapping.txt'#'-applymapping mapping.txt'#g ${proguardPath}

echo "==========config finish................."
if [[ -f ${proguardPath}.bak ]]; then
    rm ${proguardPath}.bak
fi
deleteTempMap
if [[ ${root} == *jenkins* ]]; then
    exit 0
elif [[ $3 == true ]]; then
    gradlew clean assembleRelease
    adb install -r ${root}/app/build/outputs/apk/release/*.apk
    adb shell am start -n "com.songheng.tuji.duoduo/com.songheng.tujivideo.activity.WelcomeActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
fi

