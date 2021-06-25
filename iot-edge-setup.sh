#!/usr/bin/env bash
az config set extension.use_dynamic_install=yes_without_prompt
if test -z "$(az iot hub device-identity list -n $IOTHUB | grep "deviceId" | grep $EDGE_DEVICE)"; then
    az iot hub device-identity create --hub-name $IOTHUB --device-id $EDGE_DEVICE --edge-enabled -o none
fi

DEVICE_CONNECTION_STRING=$(az iot hub device-identity connection-string show --device-id $EDGE_DEVICE --hub-name $IOTHUB --query='connectionString')
echo "{ \"deviceConnectionString\": $DEVICE_CONNECTION_STRING }" > $AZ_SCRIPTS_OUTPUT_PATH
