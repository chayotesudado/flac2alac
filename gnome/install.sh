#!/bin/bash

# Build repalac as a Flatpak and install it for the current user.
#
# Needs only flatpak and the GNOME runtime (no SDK or flatpak-builder): the app is a single
# Python file, and the runtime already ships Python, PyGObject, libadwaita and ffmpeg.
#
# Usage: ./install.sh            build and install
#        ./install.sh --bundle   also write repalac.flatpak, to install on another machine

set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

APP_ID=io.github.chayotesudado.Repalac
RUNTIME=org.gnome.Platform
VERSION=51
BUILD=.flatpak

flatpak info --user "$RUNTIME//$VERSION" &>/dev/null ||
  flatpak install --user -y flathub "$RUNTIME//$VERSION"

rm -rf "$BUILD/app"
flatpak build-init "$BUILD/app" "$APP_ID" "$RUNTIME" "$RUNTIME" "$VERSION"

install -Dm755 repalac "$BUILD/app/files/bin/repalac"
install -Dm644 "$APP_ID.desktop" "$BUILD/app/files/share/applications/$APP_ID.desktop"
install -Dm644 "icons/$APP_ID.svg" "$BUILD/app/files/share/icons/hicolor/scalable/apps/$APP_ID.svg"
install -Dm644 "icons/$APP_ID-symbolic.svg" "$BUILD/app/files/share/icons/hicolor/symbolic/apps/$APP_ID-symbolic.svg"

# Home and removable drives, so paths stay readable and output can go next to the FLACs.
# Folders elsewhere still work through the file chooser and drag and drop (portals).
flatpak build-finish "$BUILD/app" \
  --command=repalac \
  --share=ipc \
  --socket=wayland \
  --socket=fallback-x11 \
  --device=dri \
  --filesystem=home \
  --filesystem=/run/media

flatpak build-export "$BUILD/repo" "$BUILD/app"

flatpak build-bundle "$BUILD/repo" "$BUILD/repalac.flatpak" "$APP_ID" \
  --runtime-repo=https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y --reinstall --bundle "$BUILD/repalac.flatpak"

if [[ ${1:-} == --bundle ]]; then
  cp "$BUILD/repalac.flatpak" .
  echo "Wrote $PWD/repalac.flatpak"
fi

echo "Installed. Find \"Repalac\" in Activities, or run: flatpak run $APP_ID"
