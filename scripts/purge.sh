#!/bin/bash

set -e

cd ${HOME}/rigel/rigel_basestation_meta/scripts
chmod +x uninstall.sh

./uninstall.sh

cd ${HOME}
rm -rf rigel

exit(0)