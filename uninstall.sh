#!/bin/bash
CPG='\033[1;34m'
TNG='\033[1;32m'

echo -e "${CPG}Would you like to uninstall ${TNG}App1? ${CPG}[y/n] (-1.4 GB)"
read kire
if [[ $kire == y* ]]; then

        echo -e "${CPG}Deleting ${TNG}App1..."
        cd ../../
        rm -r MyCompany

        echo -e "${CPG}Removing ${TNG}Shortcut..."
        rm /usr/share/applications/app1.desktop
else
    echo "Removal Stopped"
fi
