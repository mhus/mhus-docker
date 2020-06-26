#!/bin/bash

source ./_common.sh

function build_docker_image {
	local docker_image_name
	local label_name

	if [[ ${RELEASE_FILE_NAME} == *-commerce-enterprise-* ]]
	then
		docker_image_name="commerce-enterprise"
		label_name="Liferay Commerce Enterprise"
	elif [[ ${RELEASE_FILE_NAME} == *-commerce-* ]]
	then
		docker_image_name="commerce"
		label_name="Liferay Commerce"
	elif [[ ${RELEASE_FILE_NAME} == *-dxp-* ]] || [[ ${RELEASE_FILE_NAME} == *-private* ]]
	then
		docker_image_name="dxp"
		label_name="Liferay DXP"
	elif [[ ${RELEASE_FILE_NAME} == *-portal-* ]]
	then
		docker_image_name="portal"
		label_name="Liferay Portal"
	else
		echo "${RELEASE_FILE_NAME} is an unsupported release file name."

		exit 1
	fi

	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL%} == */snapshot-* ]]
	then
		docker_image_name=${docker_image_name}-snapshot
	fi

	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == http://release-* ]] || [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == *release.liferay.com* ]]
	then
		docker_image_name=${docker_image_name}-snapshot
	fi

	local release_version=${LIFERAY_DOCKER_RELEASE_FILE_URL%/*}

	release_version=${release_version##*/}

	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == /* ]]
	then
		release_version=${LIFERAY_DOCKER_RELEASE_FILE_URL#*tomcat-}
		release_version=${release_version%.*}
	fi
	
	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == http://release-* ]] || [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == *release.liferay.com* ]]
	then
		release_version=${LIFERAY_DOCKER_RELEASE_FILE_URL#*tomcat-}
		release_version=${release_version%.*}
	fi

	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL} == *files.liferay.com/* ]] && [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL%} != */snapshot-* ]]
	then
		local file_name_release_version=${LIFERAY_DOCKER_RELEASE_FILE_URL#*tomcat-}

		file_name_release_version=${file_name_release_version%.*}
		file_name_release_version=${file_name_release_version%-*}

		if [[ ${file_name_release_version} == *-slim ]]
		then
			file_name_release_version=${file_name_release_version%-slim}
		fi

		local service_pack_name=${file_name_release_version##*-}
	fi

	if [[ ${service_pack_name} == ga* ]] || [[ ${service_pack_name} == sp* ]]
	then
		release_version=${release_version}-${service_pack_name}
	fi

	if [[ ${RELEASE_FILE_NAME} == *-commerce-* ]]
	then
		local commerce_portal_variant=${LIFERAY_DOCKER_RELEASE_FILE_URL%-*}

		commerce_portal_variant=${commerce_portal_variant: -5}

		release_version=${release_version}-${commerce_portal_variant}
	fi

	local label_version=${release_version}

	if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL%} == */snapshot-* ]]
	then
		local release_branch=${LIFERAY_DOCKER_RELEASE_FILE_URL%/*}

		release_branch=${release_branch%/*}
		release_branch=${release_branch%-private*}
		release_branch=${release_branch##*-}

		local release_hash=$(cat ${TEMP_DIR}/liferay/.githash)

		release_hash=${release_hash:0:7}

		if [[ ${release_branch} == master ]]
		then
			label_version="Master Snapshot on ${label_version} at ${release_hash}"
		else
			label_version="${release_branch} Snapshot on ${label_version} at ${release_hash}"
		fi
	fi

	if [ -n "${LIFERAY_DOCKER_RELEASE_VERSION}" ]
	then
		release_version=${LIFERAY_DOCKER_RELEASE_VERSION}
	fi

	DOCKER_IMAGE_TAGS=()

	local default_ifs=${IFS}

	IFS=","

	for release_version_single in ${release_version}
	do
		if [[ ${LIFERAY_DOCKER_RELEASE_FILE_URL%} == */snapshot-* ]]
		then
			DOCKER_IMAGE_TAGS+=("mhus/${docker_image_name}:${release_branch}-${release_version_single}-${release_hash}")
			DOCKER_IMAGE_TAGS+=("mhus/${docker_image_name}:${release_branch}-$(date "${CURRENT_DATE}" "+%Y%m%d")")
			DOCKER_IMAGE_TAGS+=("mhus/${docker_image_name}:${release_branch}")
		else
			DOCKER_IMAGE_TAGS+=("mhus/${docker_image_name}:${release_version_single}-${TIMESTAMP}")
			DOCKER_IMAGE_TAGS+=("mhus/${docker_image_name}:${release_version_single}")
		fi
	done

	IFS=${default_ifs}

	docker build \
		--build-arg LABEL_BUILD_DATE=$(date "${CURRENT_DATE}" "+%Y-%m-%dT%H:%M:%SZ") \
		--build-arg LABEL_NAME="${label_name}" \
		--build-arg LABEL_VCS_REF=$(git rev-parse HEAD) \
		--build-arg LABEL_VCS_URL="https://github.com/liferay/liferay-docker" \
		--build-arg LABEL_VERSION="${label_version}" \
		$(get_docker_image_tags_args ${DOCKER_IMAGE_TAGS[@]}) \
		${TEMP_DIR}
}

function check_usage {
	if [ ! -n "${LIFERAY_DOCKER_RELEASE_FILE_URL}" ]
	then
		echo "Usage: ${0} <push>"
		echo ""
		echo "The script reads the following environment variables:"
		echo ""
		echo "    LIFERAY_DOCKER_FIX_PACK_URL (optional): URL to a fix pack"
		echo "    LIFERAY_DOCKER_LICENSE_CMD (required for DXP): Command to generate the trial license"
		echo "    LIFERAY_DOCKER_RELEASE_FILE_URL (required): URL to a Liferay bundle"
		echo ""
		echo "Example: LIFERAY_DOCKER_RELEASE_FILE_URL=files.liferay.com/private/ee/portal/7.2.10/liferay-dxp-tomcat-7.2.10-ga1-20190531140450482.7z ${0} push"
		echo ""
		echo "Set \"push\" as a parameter to automatically push the image to Docker Hub."

		exit 1
	fi

	check_utils 7z curl docker java unzip
}

function download_trial_dxp_license {
	if [[ ${RELEASE_FILE_NAME} == *-commerce-enterprise-* ]] || [[ ${RELEASE_FILE_NAME} == *-dxp-* ]]
	then
		if [ -z "${LIFERAY_DOCKER_LICENSE_CMD}" ]
		then
			echo "Set the environment variable LIFERAY_DOCKER_LICENSE_CMD to generate a trial DXP license."

			exit 1
		else
			mkdir -p ${TEMP_DIR}/liferay/deploy

			license_file_name=license-$(date "${CURRENT_DATE}" "+%Y%m%d").xml

			eval "curl --silent --header \"${LIFERAY_DOCKER_LICENSE_CMD}?licenseLifetime=$(expr 1000 \* 60 \* 60 \* 24 \* 30)&startDate=$(date "${CURRENT_DATE}" "+%Y-%m-%d")&owner=docker%40liferay.com\" > ${TEMP_DIR}/liferay/deploy/${license_file_name}"

			sed -i "s/\\\n//g" ${TEMP_DIR}/liferay/deploy/${license_file_name}
			sed -i "s/\\\t//g" ${TEMP_DIR}/liferay/deploy/${license_file_name}
			sed -i "s/\"<?xml/<?xml/" ${TEMP_DIR}/liferay/deploy/${license_file_name}
			sed -i "s/license>\"/license>/" ${TEMP_DIR}/liferay/deploy/${license_file_name}
			sed -i 's/\\"/\"/g' ${TEMP_DIR}/liferay/deploy/${license_file_name}
			sed -i 's/\\\//\//g' ${TEMP_DIR}/liferay/deploy/${license_file_name}

			if [ ! -e ${TEMP_DIR}/liferay/deploy/${license_file_name} ]
			then
				echo "Trial DXP license does not exist at ${TEMP_DIR}/liferay/deploy/${license_file_name}."

				exit 1
			else
				echo "Trial DXP license exists at ${TEMP_DIR}/liferay/deploy/${license_file_name}."
			fi
		fi
	fi

	if [[ ${RELEASE_FILE_NAME} == *-commerce-enterprise-* ]]
	then
		if [ -z "${LIFERAY_DOCKER_COMMERCE_LICENSE_CMD}" ]
		then
			echo "Set the environment variable LIFERAY_DOCKER_COMMERCE_LICENSE_CMD to generate a trial Commerce license."

			exit 1
		else
			mkdir -p ${TEMP_DIR}/liferay/data/license

			commerce_license_file_name=LiferayCommerce_enterprise-$(date "${CURRENT_DATE}" "+%Y%m%d").li

			eval "curl --silent --header \"${LIFERAY_DOCKER_COMMERCE_LICENSE_CMD}?licenseLifetime=$(expr 1000 \* 60 \* 60 \* 24 \* 30)&startDate=$(date "${CURRENT_DATE}" "+%s%3N")&owner=docker%40liferay.com\" > ${TEMP_DIR}/liferay/data/license/${commerce_license_file_name}"

			sed -i 's/["]//g' ${TEMP_DIR}/liferay/data/license/${commerce_license_file_name}

			if [ ! -e ${TEMP_DIR}/liferay/data/license/${commerce_license_file_name} ]
			then
				echo "Trial Commerce license does not exist at ${TEMP_DIR}/liferay/data/license/${commerce_license_file_name}."

				exit 1
			else
				echo "Trial Commerce license exists at ${TEMP_DIR}/liferay/data/license/${commerce_license_file_name}."
			fi
		fi
	fi
}

function install_fix_pack {
	if [ -n "${LIFERAY_DOCKER_FIX_PACK_URL}" ]
	then
		local fix_pack_url=${LIFERAY_DOCKER_FIX_PACK_URL}

		FIX_PACK_FILE_NAME=${fix_pack_url##*/}

		download releases/fix-packs/${FIX_PACK_FILE_NAME} ${fix_pack_url}

		cp releases/fix-packs/${FIX_PACK_FILE_NAME} ${TEMP_DIR}/liferay/patching-tool/patches

		${TEMP_DIR}/liferay/patching-tool/patching-tool.sh install
		${TEMP_DIR}/liferay/patching-tool/patching-tool.sh separate temp

		rm -fr ${TEMP_DIR}/liferay/osgi/state/*
		rm -f ${TEMP_DIR}/liferay/patching-tool/patches/*
	fi
}

function main {
    echo "=== check_usage"
	check_usage ${@}

    echo "=== make_temp_directory"
	make_temp_directory

    echo "=== prepare_temp_directory"
	prepare_temp_directory ${@}

    echo "=== update_patching_tool"
	update_patching_tool

    echo "=== install_fix_pack"
	install_fix_pack ${@}

    echo "=== prepare_tomcat"
	prepare_tomcat

    echo "=== download_trial_dxp_license"
	download_trial_dxp_license

    echo "=== build_docker_image"
	build_docker_image

    # echo "=== test_docker_image"
	# test_docker_image

    #echo "=== tag_docker_images"
	#tag_docker_images ${4}
	
	echo "=== push_docker_images"
	push_docker_images ${1}

	# clean_up_temp_directory
}

function prepare_temp_directory {
	RELEASE_FILE_NAME=${LIFERAY_DOCKER_RELEASE_FILE_URL##*/}

	local release_dir=${LIFERAY_DOCKER_RELEASE_FILE_URL%/*}

	release_dir=${release_dir#*com/}
	release_dir=${release_dir#*com/}
	release_dir=${release_dir#*liferay-release-tool/}
	release_dir=${release_dir#*private/ee/}
	release_dir=releases/${release_dir}

	download ${release_dir}/${RELEASE_FILE_NAME} ${LIFERAY_DOCKER_RELEASE_FILE_URL}

	if [[ ${RELEASE_FILE_NAME} == *.7z ]]
	then
		7z x -O${TEMP_DIR} ${release_dir}/${RELEASE_FILE_NAME} || exit 3
	else
		unzip -q ${release_dir}/${RELEASE_FILE_NAME} -d ${TEMP_DIR}  || exit 3
	fi

	mv ${TEMP_DIR}/liferay-* ${TEMP_DIR}/liferay
}

function update_patching_tool {
	if [ -e ${TEMP_DIR}/liferay/patching-tool ]
	then
		mv ${TEMP_DIR}/liferay/patching-tool/patches ${TEMP_DIR}/liferay/patching-tool-upgrade-patches

		rm -fr ${TEMP_DIR}/liferay/patching-tool

		download ${TEMP_DIR}/LATEST-2.0.txt files.liferay.com/private/ee/fix-packs/patching-tool/LATEST-2.0.txt

		local latest_patching_tool_version=$(cat ${TEMP_DIR}/LATEST-2.0.txt)

		echo ""
		echo "Updating Patching Tool to version ${latest_patching_tool_version}."
		echo ""

		download releases/patching-tool/patching-tool-${latest_patching_tool_version}.zip files.liferay.com/private/ee/fix-packs/patching-tool/patching-tool-${latest_patching_tool_version}.zip

		unzip -d ${TEMP_DIR}/liferay -q releases/patching-tool/patching-tool-${latest_patching_tool_version}.zip

		${TEMP_DIR}/liferay/patching-tool/patching-tool.sh auto-discovery

		rm -fr ${TEMP_DIR}/liferay/patching-tool/patches

		mv ${TEMP_DIR}/liferay/patching-tool-upgrade-patches ${TEMP_DIR}/liferay/patching-tool/patches
	fi
}

main ${@}