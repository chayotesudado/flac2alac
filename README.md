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

## Repalac (GNOME app)

`gnome/` has Repalac, the same converter as a libadwaita app that follows the GNOME HIG: choose or drop a folder, pick where to save, convert, and see what failed. It keeps the same guarantees (verified lossless, skips done files, no half-written files), and runs in the background with a notification when it finishes.

It installs as a Flatpak, so it works on image-based systems like openSUSE Aeon without installing anything on the host. It runs on the GNOME 51 runtime, which already includes Python, libadwaita and ffmpeg:

```bash
gnome/install.sh            # build and install for your user
gnome/install.sh --bundle   # also write gnome/repalac.flatpak to install elsewhere
```

Then open "Repalac" from Activities, or `flatpak run io.github.chayotesudado.Repalac [folder]`.

The app can read and write your home folder and removable drives (`/run/media`). Folders anywhere else work through the file chooser or drag and drop.
