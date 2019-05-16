#!/bin/bash

function show_options() {
  echo ..
  echo .
  ls
  echo :exit
}

if [ -z ${EXPLORER_PATH+x} ]
then
  export EXPLORER_PATH="$(pwd)/$0"
else
  export EXPLORER_PATH="$0"
fi
EXPLORER_THEME="-theme android_notification"
EXPLORER_ROFI="rofi $EXPLORER_THEME -show-icons -dmenu"
EXPLORER_GUI="nemo"

if [ -n "$OPTION" ]
then
  if [ "$OPTION" = :exit ]
  then
    pwd
  elif [ "$OPTION" = . ]
  then
    "$EXPLORER_GUI" . &
    disown %"$EXPLORER_GUI"
  elif [[ -f "$OPTION" ]]
  then
    xdg-open "$OPTION"
  else
    cd "$OPTION"
    export OPTION=$( show_options | ($EXPLORER_ROFI) )
    "$EXPLORER_PATH"
  fi
else
  cd
  export OPTION=$( show_options | ($EXPLORER_ROFI) )
  "$EXPLORER_PATH"
fi
