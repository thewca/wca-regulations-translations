#!/bin/bash
RET=0
for file in `git diff --name-only cubing/master`; do
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
  wrc --target=check $INPUTDIR
  RET=$(($RET+$?))
done
echo "================================="
exit $RET
