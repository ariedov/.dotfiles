#!/bin/bash

update_input_source() {
    # Get current input source
    CURRENT_SOURCE=$(keyboardSwitcher get)
    
    case $CURRENT_SOURCE in
        "ABC" | "U.S.") LABEL="EN" ;;
        *) LABEL=${CURRENT_SOURCE:0:2} ;;
    esac
    
    sketchybar --set language label=$LABEL
}

case "$SENDER" in
    "routine"|"forced"|"input_source_change") 
        update_input_source
        ;;
esac