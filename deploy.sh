#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
# echo $(cd $(dirname $0);pwd)

cd ../
jb build --all jb-notes
cd -

# echo $(cd $(dirname $0);pwd)
ghp-import -n -p -f _build/html -c hangyuz.me
