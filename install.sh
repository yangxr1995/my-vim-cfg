#!/bin/bash

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
 	apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
 	    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
 	    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
 	    python3-dev git gcc g++ make automake libssl-dev flex bison clangd-10
 
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

	./configure --prefix=/usr/local/vim9 \
	--enable-rubyinterp=yes \
	--with-features=huge \
	--enable-multibyte \
	--enable-python3interp=yes \
	--enable-luainterp=yes \
	--enable-gui=gtk2 \
	--enable-cscope	

	make -j5 && make install

	cd ${TOPDIR}

	tar xf dl/tmux-3.3a.tar.gz -C ./build/
	cd build/tmux-3.3a/
	./autogen.sh 
	./configure --prefix=/usr/local/tmux
	make -j5 && make install
	cd ${TOPDIR}

	echo "PATH=/usr/local/gtags/bin:/usr/local/vim9/bin:/usr/local/tmux/bin:/usr/local/axel/bin:/usr/local/ctags/bin:${PATH}" >> /root/.bashrc

#	apt install -y curl nodejs npm clangd-10  bear tmux vim  \
#			libgraph-easy-perl  \
#			python2 python3 gdb wireguard  resolvconf

	exit 0

}

function cfg()
{
	rm -rf  ~/.vim/*
	mkdir -p ~/.vim/pack/plugins/start/

	cp -rfd vim/* ~/.vim/

	cp -f ./vimrc ~/.vimrc

	tar xf dl/coc.nvim-0.0.82.tar.gz -C ~/.vim/pack/plugins/start/
	echo "进入vim，执行 :CocInstall coc-clangd"
	echo "进入项目，执行 bear -- make"

	cat>/root/.tmux.conf<<EOF
# 改变快捷键前缀
# unbind C-b
# set -g prefix C-a

# 设置终端类型为256色
set -g default-terminal "xterm-256color"
set-option -ga terminal-overrides ",*256col*:Tc"

bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Index starts from 1
set-option -g base-index 1
setw -g pane-base-index 1   # make pane numbering consistent with windows
set-option -g mouse on
EOF
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
