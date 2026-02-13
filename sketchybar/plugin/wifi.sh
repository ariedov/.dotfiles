#!/bin/bash

# Get WiFi device name
WIFI_DEVICE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

# Check if WiFi is on
WIFI_STATUS=$(networksetup -getairportpower "$WIFI_DEVICE" | awk '{print $4}')

# Get current SSID
SSID=$(networksetup -getairportnetwork "$WIFI_DEVICE" | sed 's/Current Wi-Fi Network: //')

# WiFi icons
ICON_CONNECTED="󰖩"
ICON_DISCONNECTED="󰖪"

# Check if WiFi is connected
if [ "$WIFI_STATUS" = "Off" ]; then
    sketchybar --set "$NAME" \
        icon="$ICON_DISCONNECTED"
elif [ "$SSID" = "You are not associated with an AirPort network." ]; then
    sketchybar --set "$NAME" \
        icon="$ICON_CONNECTED"
else
    sketchybar --set "$NAME" \
        icon="$ICON_CONNECTED" \
        label="$SSID" \
        icon.color=0xff8aadf4
fi
