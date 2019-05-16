#!/bin/bash

function show_options() {
  echo ..
  echo .
  ls
  echo :exit
}

EXPLORER_THEME="-theme android_notification"
EXPLORER_ROFI="rofi $EXPLORER_THEME -show-icons -dmenu"

if [ -n "$OPTION" ]
then
  if [ "$OPTION" = :exit ]
  then
    pwd
  elif [ "$OPTION" = . ]
  then
    nemo . &
    disown %nemo
  elif [[ -f "$OPTION" ]]
  then
    xdg-open "$OPTION"
  else
    cd "$OPTION"
    export OPTION=$( show_options | ($EXPLORER_ROFI) )
    ~/Documentos/explorer.sh
  fi
else
  cd
  export OPTION=$( show_options | ($EXPLORER_ROFI) )
  ~/Documentos/explorer.sh
fi
