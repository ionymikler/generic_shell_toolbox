# Generic Shell Toolbox (GST) [1.2.2]
Nice little collection of shell tools for the everyday dev

# Installation
1. Run `./install.sh` to install the toolbox

## Uninstall
1. Run `gst_uninstall`

# Functionality
## Enable/Disable
By default, GST comes enabled, to disbale it, run
`gst_disble'

Similarly, to re-enable it run:
`gst_enable'

# New version procedure
## New version pushed
* `git tag -a stable/x.y.z -m <message>`
* `git tag --delete stable/latest` - delete the local tag
* `git push origin --delete stable/latest` - delete the remote tag
* `git tag stable/latest` - create the local tag
* `git push origin --tags`
* 
## New version pulled
* `git checkout main`
* `git tag --delete stable/latest` 
* `git fetch`
* `git checkout stable/latest`