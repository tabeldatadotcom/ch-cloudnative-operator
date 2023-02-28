#!/bin/bash
while getopts f:n: flag
do
    case "${flag}" in
        f) TEST_SCRIPT_FILE=${OPTARG};;
        n) TEST_NAME=${OPTARG};;
    esac
done

export JMETER_HOME=~/Applications/apache-jmeter/bin
export OUTPUT_DIR=~/jmeter
export EXPORT_DIR_PATH=/${TEST_NAME}
export WEBAPP_STATIC=/var/www/html/jmeter

mkdir -p ${OUTPUT_DIR}${EXPORT_DIR_PATH}/
rm -rf ${WEBAPP_STATIC}${EXPORT_DIR_PATH}/*
mkdir -p ${WEBAPP_STATIC}${EXPORT_DIR_PATH}/

${JMETER_HOME}/jmeter -n \
-t ${TEST_SCRIPT_FILE} \
-l ${OUTPUT_DIR}${EXPORT_DIR_PATH}/cloud.jtl \
-e -o ${OUTPUT_DIR}${EXPORT_DIR_PATH}/

mv ${OUTPUT_DIR}${EXPORT_DIR_PATH}/* ${WEBAPP_STATIC}${EXPORT_DIR_PATH}
echo "${WEBAPP_STATIC}${EXPORT_DIR_PATH}"
