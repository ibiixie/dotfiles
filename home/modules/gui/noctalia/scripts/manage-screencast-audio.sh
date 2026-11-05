#!/usr/bin/env bash

get_id() {
  local name="$1"

  local id
  id=$(pw-dump | jq -r --arg name "$name" \
    '.[] | select(.info.props["node.name"]=="combine.\($name)-to-loopback.screenshare-mix.stream") | .id')
  
  printf '%s\n' "$id"
}

is_mute() {
  local name="$1"

  local id
  id=$(get_id "$name")

  [[ -n "$id" ]] || return 1

  local volume
  volume=$(wpctl get-volume "$id")

  [[ "$volume" == *"[MUTED]"* ]]
}

toggle_mute() {
  local name="$1"

  local id
  id=$(get_id "$name")

  [[ -n "$id" ]] || return 1

  wpctl set-mute "$id" toggle
}

if is_mute "system"; then
  icon="  "
else
  icon="  "
fi

dmenu_input=$'\n'"$icon System Mix"

if is_mute "media"; then
  icon="  "
else
  icon="  "
fi

dmenu_input+=$'\n'"$icon Media Mix"

choice=$(printf '%s\n' "$dmenu_input" | noctalia dmenu -p "Screenshare Audio Mixer")

case "$choice" in
  *"System Mix") toggle_mute "system" ;;
  *"Media Mix")  toggle_mute "media" ;;
esac
