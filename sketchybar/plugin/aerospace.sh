#!/bin/bash

# Get the focused window from aerospace
WORKSPACE=$(aerospace list-workspaces --focused)
MODE=$(aerospace list-modes --current)

# If no window is focused or aerospace command fails, show a default message
if [ -z "$WORKSPACE" ]; then
    WORKSPACE="#"
fi

if [ "$MODE" == "service" ]; then
    WORKSPACE="$WORKSPACE*"
fi

sketchybar --set aerospace_workspace label="$WORKSPACE"
