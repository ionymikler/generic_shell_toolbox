# Changelog

## 1.0.0
* Base version

### 1.0.1
* issue #1: branch name bug fixed
* changelog implemented

### 1.0.2
* Feature: enable/disable toggle of the toolbox

### 1.0.3
* option to source the toolbox to bashrc from install script

### 1.0.4
* enable/disable
* uninstall capacity
* installation enabled
* gst_* commands started

### 1.0.5
* rebash function corrected

## 1.1.0
Major
* "Extentions" introduced
* ROS(2) related functionality included as an 'extension'

Minor
* GST_SOURCE_FILE implemented for universal sourcing variable

### 1.1.1
* command `cdws` now has a source flag (-s) for sourcing the ws after cd

## 1.2.0
Major
* '-D' flag in installation script to bypass prompts

### 1.2.1
Minor
* Minor reformatting of the .env file at install-time

### 1.2.2
Minor
* typo correction in .make_env ...

### 1.2.3
Minor
* Installation script can be run now with flag `-D` for default and `-y` for promptless 
* Version now appear in source message

## 1.3.0
Minor
* Script `create_stable_tag.sh` for ease of tag release

## 1.4.0
Minor
* (set/get)_ros_ws commands fixed and renamed to gst_ros_(set/get)_ws

### 1.4.1
Minor
* Fixed gst_ros_set_ws bug where loading from config would incorrectly re-validate and rewrite the config file

### 1.4.2
Minor
* Added `update_from_stable.sh` for updating a tarball installation to the newest `stable/latest` tag (#45)

### 1.4.3
Minor
* PS1 shows the last 4 characters of the HEAD commit after the branch name (#49)

## 1.5.0
Fixes
* GST no longer leaks `SCRIPT_DIR`, `main` or its internal loader helpers (`gst_main`, `source_core`, `gst_sourcing`, …) into the user's shell. They overwrote same-named globals from other sourced scripts (#52, #54, see #51)
* Answering "n" to the default PS1 at install now keeps the user's own PS1 colours; an old GST PS1 in `.env` is removed (#53)
* The "Replace existing env file?" prompt now appears (fixed a `[[ ]]` syntax error) and `-y` reaches it (#53)
* Reinstalling no longer adds duplicate `source` lines to `~/.bashrc` or duplicate `SOURCING_FILE_PATH`/PS1 lines to `.env` (#53)
* The git addon's colour codes in the PS1 are wrapped in `\[ \]`, so long command lines wrap correctly (#53)

Changes
* Internal loader helpers are now prefixed `_gst_` and removed after loading
* Removed the unused `EXTENSIONS` array and `source_extention` function
