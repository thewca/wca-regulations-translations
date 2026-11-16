#!/usr/bin/env -S bash --

set -euo pipefail

EXIT_CODE=0

## TODO: the following code isn't working. Ideally, this should diff against:
##
## - [`https://docs.github.com/en/actions/reference/workflows-and-actions/contexts#:~:text=GitHub%20Actions.-,github.base_ref,-string`](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts#:~:text=GitHub%20Actions.-,github.base_ref,-string)
## - `main` in local dev.
##
# for file in `git diff --name-only thewca/main`; do
#   if [[ $file == */wca-regulations.md || $file == */wca-guidelines.md ]]; then
#     echo "Detected change for file $file, running diff."
#     wrc $file --diff wca-regulations-official
#     EXIT_CODE=$(($EXIT_CODE+$?))
#   fi
# done

LANGUAGES=$(wrc-languages)
echo "================================="
mkdir "build"
for l in $LANGUAGES; do
  INPUTDIR=${l}
  echo "Doing check for language "${l}
  wrc "$INPUTDIR"/wca-regulations.md --target=check
  EXIT_CODE=$((EXIT_CODE+$?))
done
echo "================================="
exit $EXIT_CODE
