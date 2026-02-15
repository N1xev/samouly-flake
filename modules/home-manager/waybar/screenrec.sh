#!/usr/bin/env bash

# Parse command line arguments
SILENT=false
COMPRESS=true
while [[ $# -gt 0 ]]; do
  case $1 in
  --silent)
    SILENT=true
    shift
    ;;
  --no-compress)
    COMPRESS=false
    shift
    ;;
  *)
    echo "Unknown option: $1"
    echo "Usage: $0 [--silent] [--no-compress]"
    exit 1
    ;;
  esac
done

SAVE_DIR="$HOME/Videos"
mkdir -p "$SAVE_DIR"

# Function to update waybar
update_waybar() {
  sleep 0.5
  pkill -RTMIN+8 waybar 2>/dev/null || true
}

# ── Stop if already recording ──────────────────────────────────────────────
if pgrep -x wl-screenrec >/dev/null; then
  pkill -INT wl-screenrec

  # Wait up to 3 seconds for graceful shutdown
  for i in {1..15}; do
    pgrep -x wl-screenrec >/dev/null || break
    sleep 0.2
  done

  # Force kill if still running
  if pgrep -x wl-screenrec >/dev/null; then
    pkill -9 wl-screenrec
    sleep 0.3
  fi

  LATEST=$(ls -t "$SAVE_DIR"/*.mp4 | head -n1)

  # Compress the video if enabled
  if [[ "$COMPRESS" == true ]] && command -v ffmpeg >/dev/null; then
    notify-send "Compressing video..." "Please wait" --expire-time=2000

    COMPRESSED="${LATEST%.mp4}_compressed.mp4"
    if ffmpeg -i "$LATEST" -c:v libx264 -crf 23 -preset medium -c:a copy -movflags +faststart "$COMPRESSED" -y 2>/dev/null; then
      ORIG_SIZE=$(du -h "$LATEST" | cut -f1)
      COMP_SIZE=$(du -h "$COMPRESSED" | cut -f1)
      mv "$COMPRESSED" "$LATEST"
      notify-send "Recording finished & compressed" "Size: $ORIG_SIZE → $COMP_SIZE" --expire-time=2500
    else
      notify-send "Recording finished" "Compression failed, keeping original" --expire-time=2500
    fi
  else
    notify-send "Recording finished" "Path copied: $(basename "$LATEST")" --expire-time=1500
  fi

  echo "$LATEST" | wl-copy

  if command -v xdg-open >/dev/null; then
    xdg-open "$(dirname "$LATEST")" &
  fi

  update_waybar &
  exit 0
fi

# ── Pick region ────────────────────────────────────────────────────────────
REGION=$(slurp) || exit 1

FILE="$SAVE_DIR/$(date +'%Y-%m-%d_%H-%M-%S').mp4"

if [[ "$SILENT" == false ]]; then
  MIC_SRC=$(pactl info | awk -F': ' '/Default Source/ {print $2}')
  AUDIO_SRC="$MIC_SRC"
  DESC=$(pactl list sources | awk -v s="$AUDIO_SRC" '$2==s {getline;sub(/^\s*Description: /,"");print;exit}')

  notify-send "Recording… (source: $DESC)" --expire-time=1000
  wl-screenrec -g "$REGION" --audio --audio-device "$AUDIO_SRC" -f "$FILE" &
else
  notify-send "Recording… (silent mode)" --expire-time=1000
  wl-screenrec -g "$REGION" -f "$FILE" &
fi

update_waybar &
