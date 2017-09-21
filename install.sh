#!/bin/bash

set -e

prefs=~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences-3.plist
syncfolder=$(/usr/libexec/PlistBuddy -c "print :syncfolder" $prefs)
workflows=$syncfolder/Alfred.alfredpreferences/workflows
workflows=${workflows/\~/$HOME} # expand ~/
ln -s "$(pwd)" "$workflows"
