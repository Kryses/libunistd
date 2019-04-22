#!/bin/bash 
# cmaker_cmakelist.sh
# Created by Robin Rowe 2019/1/11
# License MIT open source

cmakelist=CMakeLists.txt
date=$(date +%Y-%m-%d)
project=$1
project_file="$0.txt"

CreateDocs()
{	docfile=CHANGES.md
	if [[ ! -e ${docfile} ]]; then
		echo "Writing ${docfile}"
		echo "#${docfile}" > ${docfile}
		echo "" >> ${docfile}
		echo "${AUTHOR} ${data}" >> ${docfile}
		echo "" >> ${docfile}
		echo "## To-Do" >> ${docfile}
		echo "" >> ${docfile}
		echo "## Done" >> ${docfile}
		echo "" >> ${docfile}
	fi
	docfile=README.md
	if [[ ! -e ${docfile} ]]; then
		echo "Writing ${docfile}"
		echo "#${docfile}" > ${docfile}
		echo "" >> ${docfile}
		echo "${AUTHOR} ${data}" >> ${docfile}
		echo "" >> ${docfile}
	fi
}

ReadLicenseFile()
{	if [[ ! -e LICENSE ]]; then
		echo "Missing LICENSE file"
		if [[ -e ../LICENSE ]]; then
			echo "Copying LICENSE file"
			cp ../LICENSE .
		else
			exit 1
		fi
	fi
	read -r license < LICENSE
	echo "License: ${license}"
}

Sed()
{	local arg=$1
	local file=$2
	sed "${arg}" ${file} > ${file}.tmp
	mv -f ${file}.tmp ${file}
}

CreateCmakeList() 
{	if [[ -e ${cmakelist} ]]; then
		echo "Skipping... ${cmakelist} already exists!"
		return
	fi
	if [[ -e ${cmakelist} ]]; then
		echo "Skipping... ${cmakelist} already exists!"
		return
	fi
	echo Creating ${cmakelist} for project ${project}...
	cp ${project_file} ${cmakelist}
	Sed "s/PROJECT/${project}/g" ${cmakelist}
	Sed "s/DATE/${date}/g" ${cmakelist}
	Sed "s/AUTHOR/${AUTHOR}/g" ${cmakelist}
	Sed "s/LICENSE/${license}/g" ${cmakelist}
}

main()
{	if [ -z "${project}" ]; then 
		echo 'Usage: % make_cmake Project_Name'
		exit 1
	fi
	if [ -z "$AUTHOR" ]; then 
		echo "In bash set your name: % export AUTHOR=\"Your Name\""
		exit 1
	fi
	ReadLicenseFile
	CreateCmakeList
	CreateDocs
#	cat ${cmakelist}
}

main
