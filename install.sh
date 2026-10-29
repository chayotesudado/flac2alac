#!/bin/bash

# Symlink flac2alac and its launcher entry into place, so edits in this repo take effect immediately.

set -e
cd "$(dirname "$(realpath "$0")")"

mkdir -p ~/.local/bin ~/.local/share/applications
ln -sfn "$PWD/flac2alac" ~/.local/bin/flac2alac
ln -sfn "$PWD/flac2alac.desktop" ~/.local/share/applications/flac2alac.desktop

echo "Installed. Run flac2alac, or find \"FLAC to ALAC\" in the app launcher (SUPER + SPACE)."
