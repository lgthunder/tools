#!/bin/sh
pluginName=$1
rootDir=buildSrc
javaDir=${rootDir}/src/main/java
groovyDir=${rootDir}/src/main/groovy
pluginPropertyDir=${rootDir}/src/main/resources/META-INF/gradle-plugins


if [[ -d ${rootDir} ]]; then
	#statements
	echo "${rootDir} exsit"
else
	mkdir -p ${javaDir}
	mkdir -p ${groovyDir}
	mkdir -p ${pluginPropertyDir}
fi

if [[ $1 ]]; then
	str=${1//\./ }
	arr=($str)
	dir=""
	for each in ${arr[*]}
	do
		dir=${dir}/${each}
	done
	mkdir -p ${javaDir}${dir}
	mkdir -p ${groovyDir}${dir}
fi

if [[ -d ${pluginPropertyDir} ]]; then
	#statements
	touch ${pluginPropertyDir}/${pluginName}.properties
	echo "implementation-class=${pluginName}.your-implementation">>${pluginPropertyDir}/${pluginName}.properties
fi

if [[ -d ${rootDir} ]]; then
	#statements
	buildSrc=${rootDir}/build.gradle
	# touch ${buildSrc}
	echo "apply plugin: 'groovy'">> ${buildSrc}
	echo $'\n'>>${buildSrc}
	echo 'buildscript {'>> ${buildSrc}
	echo '   repositories {'>> ${buildSrc}
	echo '        mavenCentral()'>> ${buildSrc}
	echo '        jcenter()'>> ${buildSrc}
	echo '        google()'>> ${buildSrc}
	echo '    }'>> ${buildSrc}
	echo ''>> ${buildSrc}
	echo '    dependencies {'>> ${buildSrc}
	echo "        classpath 'com.android.tools.build:gradle:3.1.3'">> ${buildSrc}
	echo '    }'>> ${buildSrc}
	echo '}'>> ${buildSrc}
	echo ''>> ${buildSrc}
	echo 'dependencies {'>> ${buildSrc}
	echo '    implementation gradleApi()'>> ${buildSrc}
	echo '    implementation localGroovy()'>> ${buildSrc}
	echo "    implementation 'com.android.tools.build:gradle:3.1.3'">> ${buildSrc}
	echo '}'>> ${buildSrc}
	echo ''>> ${buildSrc}
	echo 'allprojects {'>> ${buildSrc}
	echo '    repositories {'>> ${buildSrc}
	echo '        mavenCentral()'>> ${buildSrc}
	echo '        google()'>> ${buildSrc}
	echo '    }'>> ${buildSrc}
	echo '}'>> ${buildSrc}
	echo ''>> ${buildSrc}
	echo 'sourceSets {'>> ${buildSrc}
	echo '    main {'>> ${buildSrc}
	echo "        java.srcDirs = ['src/main/java'">> ${buildSrc}
	echo "//                        '../other plugin dir/src/main/java'">> ${buildSrc}
	echo '        ]'>> ${buildSrc}
	echo "        groovy.srcDirs = ['src/main/groovy'">> ${buildSrc}
	echo "//                          '../other plugin dir/src/main/groovy'">> ${buildSrc}
	echo "        ]">> ${buildSrc}
	echo "        resources.srcDirs = ['src/main/resources'">> ${buildSrc}
	echo "//                             '../other plugin dir/src/main/resources'">> ${buildSrc}
	echo '        ]'>> ${buildSrc}
	echo '    }'>> ${buildSrc}
	echo '}'>> ${buildSrc}
fi
