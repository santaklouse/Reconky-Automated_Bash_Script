#!/usr/bin/env bash
#Author:Shivam-Rai
#Description:Installation Script.Run this before reconky.sh to install the required requirments needed for the scripts...
echo -e '.___                 __         .__  .__          __  .__               
|   | ____   _______/  |______  |  | |  | _____ _/  |_|__| ____   ____  
|   |/    \ /  ___/\   __\__  \ |  | |  | \__  \\   __\  |/  _ \ /    \ 
|   |   |  \\___ \  |  |  / __ \|  |_|  |__/ __ \|  | |  (  <_> )   |  \
|___|___|  /____  > |__| (____  /____/____(____  /__| |__|\____/|___|  /
         \/     \/            \/               \/                    \/ '
echo
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh requires root privileges"
    exit 0
fi
echo
apt-get update

#if [ ! -e /usr/lib/go/bin/./go ];then
#	apt-get install golang -y
#	ln -sfv /usr/lib/go/bin/./go /usr/bin/go
#else
#	echo "Go is already installed"
#fi

# install gvm (Go Version Manager)
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

export GVM_ROOT=/root/.gvm
source $GVM_ROOT/scripts/gvm-default

if [ ! -e "$(which gvm)" ];then
    export PATH="$GVM_ROOT/bin:$PATH"
fi

gvm install go1.16
gvm use go1.16

apt-get install zip -y
apt-get install python3-pip
echo
cd /opt

echo 'Install EyeWitness'

git clone --depth=1 https://github.com/FortyNorthSecurity/EyeWitness.git 
cd ./EyeWitness/Python/setup
./setup.sh
cd ../
a=$(pwd)
ln -sfv $a/EyeWitness.py /usr/bin/eyewitness

echo 'Install httprobe'

echo
#if [ ! -e /usr/bin/httprobe ];then
if [ ! -e "$(which httprobe)" ];then
	go get -u github.com/tomnomnom/httprobe
#	ln -sfv /root/go/bin/./httprobe /usr/bin/httprobe
else
	echo "Httprobe is already installed"
fi

echo 'Install waybackurls'

if [ ! -e "$(which waybackurls)" ];then
	go get github.com/tomnomnom/waybackurls
#	ln -sfv /root/go/bin/./waybackurls /usr/bin/waybackurls
else
	echo "Waybackurl is already installed"
fi

echo 'Install subjack'

if [ ! -e "$(which subjack)" ];then
	go get github.com/haccer/subjack
#	ln -sfv /root/go/bin/./subjack /usr/bin/subjack
else
	echo "Subjack is already installed"
fi

echo 'Install assetfinder'

if [ ! -e "$(which assetfinder)" ];then
	go get -u github.com/tomnomnom/assetfinder
#	ln -sfv /root/go/bin/./assetfinder /usr/bin/assetfinder
else
	echo "Assetfinder is already Installed"
fi

echo 'Install amass'

if [ ! -e "$(which amass)" ];then
	go get -v github.com/OWASP/Amass/v3/...
else
	echo "Amass is already installed"
fi

#if [ $? -ne 0 ];then

if [ ! -e "$(which amass)" ];then
    echo " Amass not found"
    echo -n '...snap?'
    if [ -e "$(which snap)" ];then
        echo -n '...installing'
        snap install amass
        if [ $? -ne 0 ];then
            echo -n '...Error!'
        else
            echo -n '...Done!'
        fi
    else
        echo -n '...snap not found!'
        echo 'Please install Amass manually'
    fi
fi
#fi

echo 'Install sublist3r'

if [ ! -e "$(which sublist3r)" ];then
#if [ ! -e /usr/bin/sublist3r ];then
	cd /opt
	mkdir tools
	cd tools
	git clone --depth=1 https://github.com/aboul3la/Sublist3r.git
	cd Sublist3r
	pip3 install -r requirements.txt
	cd ../
	update-alternatives --install /usr/bin/python python /usr/bin/python3 1
	ln -sfv /opt/tools/Sublist3r/sublist3r.py /usr/bin/sublist3r
else
	echo "Sublist3r is already Installed"
fi

echo 'Install knockpy'

if [ ! -e "$(which knockpy)" ];then
#if [ ! -e /usr/bin/knockpy ];then
	cd /opt/tools
	git clone --depth=1 https://github.com/guelfoweb/knock.git
	cd knock
    pip3 install -r requirements.txt
	python3 setup.py install
else
	echo "Knockpy is already Installed"
fi

