#!/bin/bash

set -e

TOPDIR=$(pwd)

function blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

function install_tools()
{
	cat > /etc/apt/sources.list << EOF
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# Needs 'sudo add-apt-repository ppa:ubuntu-toolchain-r/test' for libstdc++ with C++20 support
# 15
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-15 main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-15 main
# 16
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-16 main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-16 main
EOF

	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -

 	apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
 	    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev

	apt-get install -y  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev

	apt-get install -y  python3-dev git gcc g++ make automake libssl-dev flex bison clangd-19 nodejs

	apt-get install -y libssl1.0-dev wireguard resolvconf libevent-dev

	ln -s /usr/bin/clangd-19 /usr/bin/clangd

	apt-get install nodejs-dev -y
#	apt-get install node-gpy -y
	apt-get install npm -y

	npm config set registry https://registry.npmmirror.com
	npm config set strict-ssl false
	npm install -g n
	n 16.18.0
 
	apt install  \
		libpython3.8 \
		libpython3.8-dev \
		libpython3.8-minimal \
		libpython3.8-stdlib \
		python3.8 \
		python3.8-dev \
		python3.8-minimal \

	apt install python3-distutils -y

	python3.8 ./get-pip.py

 	mkdir build -p
 
 	dpkg -i dl/ripgrep_12.1.1_amd64.deb
 
 	tar xf dl/universal-ctags-6.1.0.tar.gz  -C build
 	cd build/universal-ctags-6.1.0/
 	./configure --prefix=/usr/local/ctags
 	make -j5 && make install
 	cd ${TOPDIR}
 
 	tar xf ./dl/global-6.6.11.tar.gz -C ./build
 	cd build/global-6.6.11
 	./configure --prefix=/usr/local/gtags && make -j4 && make install
 	cd ${TOPDIR}
 
 	tar xf dl/axel-2.17.13.tar.xz -C ./build/
 	cd build/axel-2.17.13/
 	./configure --prefix=/usr/local/axel
   	make -j5 && make install
 	cd ${TOPDIR}
 
 	tar xf dl/v9.1.0196.tar.gz -C ./build
	cd build/vim-9.1.0196

	./configure --with-features=huge  \
	--enable-rubyinterp  \
	--enable-luainterp  \
	--enable-perlinterp  \
	--enable-multibyte  \
	--enable-cscope  \
	--prefix=/usr/local/vim9 \
	--with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu \
	--enable-python3interp=yes  \
	--with-python3-command=python3 \
	--with-python3-stable-abi=3.8

	make -j5 && make install

	cd ${TOPDIR}

	tar xf dl/tmux-3.3a.tar.gz -C ./build/
	cd build/tmux-3.3a/
	./autogen.sh 
	./configure --prefix=/usr/local/tmux
	make -j5 && make install
	cd ${TOPDIR}

	echo "PATH=/usr/local/gtags/bin:/usr/local/vim9/bin:/usr/local/tmux/bin:/usr/local/axel/bin:/usr/local/ctags/bin:${PATH}" >> /root/.bashrc
}

function cfg()
{
	rm -rf  ~/.vim/*
	mkdir -p ~/.vim/pack/plugins/start/

	cp -rfd vim/* ~/.vim/

	cp -f ./vimrc ~/.vimrc

	tar xf dl/coc.nvim-0.0.82.tar.gz -C ~/.vim/pack/plugins/start/

	export 'PATH=~/.tmux/plugins/tmuxifier/bin/:$PATH' >> ~/.bashrc
	echo 'eval "$(tmuxifier init -)"' >> ~/.bashrc
	echo 'EDITOR=vim' >> ~/.bashrc

	apt install xsel -y

	mkdir -p ~/.tmux/plugins
	cp ./tmux/tpm ~/.tmux/plugins -rfd
	cp ./tmux/tmux.conf ~/.tmux.conf

	echo "安装tmux插件"
	echo "1. 运行tmux"
	echo "2. ~/.tmux/plugins/tpm/bin/install_plugins"
	echo "进入vim，执行 :CocInstall coc-clangd"
	echo "进入vim，执行 :CocInstall @yaegassy/coc-pylsp"
	echo "进入vim，执行 :CocCommand pylsp.builtin.install"
	echo "进入项目，执行 bear make"
}

function start_menu()
{
	green "1)安装 tools"
	blue "2)配置"
	blue "0)退出"
	read -p "请选择" num
	case $num in	
		1)
			install_tools
			;;
		2)
			cfg
			;;
		0)
			exit
			;;
	esac

	
	if [ $? -ne 0 ]; then
		red "操作失败"
		return 1
	else
		green "操作成功"
		return 0
	fi
}

start_menu
