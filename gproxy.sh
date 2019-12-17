#!/bin/sh
path=gradle.properties

# flag=`grep "systemProp.http.proxyPort.*" ${path}`
# if [[ -n ${flag} ]]; then
# 	sed -i.bak s#"systemProp.http.proxyPort.*"#"systemProp.http.proxyPort=1080"#g ${path}
# else
# 	"systemProp.http.proxyPort=1080">> ${path}
# fi

sed -i /"[ \f\n\r\t\v]*systemProp.http.*proxy.*"/d ${path}

echo $'\n'>>${path}
echo "#gradle proxy">>${path}
echo "systemProp.http.proxyHost=127.0.0.1">> ${path}
echo "systemProp.http.proxyPort=1080">> ${path}
echo "systemProp.https.proxyHost=127.0.0.1">> ${path}
echo "systemProp.https.proxyPort=1080">> ${path}
 

if [ -f ${path}.bak ]
then
rm ${path}.bak
fi