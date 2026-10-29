# flac2alac

A small terminal app for Omarchy that converts a folder of FLAC files to ALAC (`.m4a`) for Apple devices.

- Browse to a folder (type to search), choose to write the files next to the FLACs or into another folder, confirm, done
- Searches subfolders, keeps tags and the front cover image
- Lossless: every file is checked by hashing the decoded audio of the FLAC and the new `.m4a`; a file only counts as done if they match
- Re-running skips files that are already converted; an interrupted run leaves no half-written files
- Follows the current Omarchy theme

Needs `ffmpeg` and `gum`, both included with Omarchy.

## Install

```bash
./install.sh
```

This symlinks `flac2alac` into `~/.local/bin` and the launcher entry into `~/.local/share/applications`.

## Usage

```bash
flac2alac              # pick the source folder interactively
flac2alac ~/Music/X    # start with a source folder
```
