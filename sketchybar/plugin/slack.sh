#!/bin/bash

BADGE_RESULT=$(lsappinfo -all info -only StatusLabel "Slack" | sed -nr 's/\"StatusLabel\"=\{ \"label\"=\"(.+)\" \}$/\1/p')

if [[ "$BADGE_RESULT" =~ ([0-9]+) ]]; then
    sketchybar --set slack icon.color=0xffff6b6b
else
    sketchybar --set slack icon.color=0xffffffff
fi