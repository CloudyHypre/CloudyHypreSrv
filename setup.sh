#!/bin/bash
#setup CloudyHypreSrv

echo "  ____ _                 _       _   _                      ____             "
echo " / ___| | ___  _   _  __| |_   _| | | |_   _ _ __  _ __ ___/ ___| _ ____   __"
echo "| |   | |/ _ \| | | |/ _' | | | | |_| | | | | '_ \| '__/ _ \___ \| '__\ \ / /"
echo "| |___| | (_) | |_| | (_| | |_| |  _  | |_| | |_) | | |  __/___) | |   \ V / "
echo " \____|_|\___/ \__,_|\__,_|\__, |_| |_|\__, | .__/|_|  \___|____/|_|    \_/  "
echo "                           |___/       |___/|_|                              "
echo

which make
which gcc
which git

read -p "Everything installed? [Y/n]" in
if [ "$in" == "Y" ] || [ "$in" == "y" ] || [ "$in" == "" ]; then
    echo
else
    exit 0
fi

echo Installing missing dependencies

if [ ! -d spring-server ]; then
    echo Installing spring server
    git clone git@github.com:bartobri/spring-server.git
    cd spring-server
    make
    cd ..
    echo
fi

if [ ! -d hypre ]; then
    echo Installing hypre
    git clone git@github.com:LLNL/hypre.git
    cd hypre/src
    ./configure
    make install
    cd ../..
    echo
fi

make
