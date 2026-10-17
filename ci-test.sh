#!/bin/bash
#comment: This script is used to run the wrc tool on the wca-regulations.md and wca-guidelines.md files in the repository. It checks for changes in these files and runs a diff against the official regulations. It also checks all translations of the regulations for errors.
RET=0
for file in `git diff --name-only thewca/master`; do
  if [[ $file == */wca-regulations.md || $file == */wca-guidelines.md ]]; then
    echo "Detected change for file $file, running diff."
    wrc $file --diff wca-regulations-official
    RET=$(($RET+$?))
  fi
done

LANGUAGES=`wrc-languages`
echo "================================="
mkdir "build"
for l in $LANGUAGES; do
  INPUTDIR=${l}
  echo "Doing check for language "${l}
  wrc $INPUTDIR/wca-regulations.md --target=check
  RET=$(($RET+$?))
done
echo "================================="
exit $RET
