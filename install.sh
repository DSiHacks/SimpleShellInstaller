#!/bin/bash
CPG='\033[1;34m'
TNG='\033[1;32m'
RED='\033[0;31'
SSIVER="0.1 RC"

version() #Version functions
    { 
        echo SimpleShellInstaller ${SSIVER}; 
    } 

silentinstall() #In development
    {
        mkdir /opt/MyCompany
        mkdir /opt/MyCompany/App1
        cp TestApp /opt/MyCompany/App1
        cp uninstall.sh /opt/MyCompany/App1
    }

createshortcut()
    {
cat > app1.desktop <<EOF
[Desktop Entry]
Type=Application
Version=0.1 RC
Name=SimpleShellInstaller TestApp
Comment=A test binary.
Exec=${STOCKDIR}/MyCompany/App1/TestApp
Icon=${STOCKDIR}/MyCompany/App1/icon.png
Terminal=false
Categories=Application;
EOF
    }

custominstalldir()
    {
            echo -e "${CPG}Kindly type in the directory you want to install App1 to, make sure to type it like this -> ${RED}/dir/where/App1/will/be"
            read CUSTOMDIR
            STOCKDIR=${CUSTOMDIR}
            [  -z "$STOCKDIR" ] && STOCKDIR="/opt" || mkdir ${STOCKDIR}
    }

while getopts ":v, :s, :d" option; do
   case $option in
      v) #Version
         version
         exit;;
      s) #Silent-Install
         silentinstall
         exit;;
      d) #Use doas instead of sudo
         ROOTCMD="doas"
         exit;;
     \?) #Bad arg
         echo Uh Oh, Bad Syntax!
         exit;;
   esac
done

#Actual Installing
echo -e "${CPG}Would you like to install ${TNG}App1? ${CPG}[y/n] (1.4 GB)"
read kire
if [[ $kire == y* ]]; then
        custominstalldir
        mkdir ${STOCKDIR}/MyCompany
        mkdir ${STOCKDIR}/MyCompany/App1

        echo -e "${CPG}Copying ${TNG}Executables..."
        cp TestApp ${STOCKDIR}/MyCompany/App1
        cp uninstall.sh ${STOCKDIR}/MyCompany/App1

        echo -e "${CPG}Copying ${TNG}Data..."
        cp icon.png ${STOCKDIR}/MyCompany/App1

        echo -e "${CPG}Adding ${TNG}Shortcut..."
        cd /tmp
        createshortcut
        chmod +x app1.desktop
        cp app1.desktop /usr/share/applications
        rm app1.desktop

        echo -e "${CPG}TestApp has been installed onto your computer!"
else
    echo "Installation Stopped"
fi
