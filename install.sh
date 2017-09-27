#!/bin/bash

set -e

prefs=~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences-3.plist
syncfolder=$(/usr/libexec/PlistBuddy -c "print :syncfolder" $prefs 2>/dev/null || echo)
if [ -z "$syncfolder" ]; then
  syncfolder=~/Library/Application\ Support/Alfred\ 3
fi

workflows=$syncfolder/Alfred.alfredpreferences/workflows
workflows=${workflows/\~/$HOME} # expand ~/

if [ -d "$workflows" ]; then
  echo "symlinking $(pwd) into $workflows"
  ln -s "$(pwd)" "$workflows"
else
  echo "Could not find workflows folder: $workflows"
  exit 1
fi
