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
* `git tag -fa stable/latest -m "Update stable/latest to this commit"` - Update 'latest' tag
* `git push origin stable/latest --force` - update origin

## New version pulled
* `git checkout stable/latest`