#!/bin/bash

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
	apt install -y nodejs npm clangd  bear tmux vim  \
			universal-ctags libgraph-easy-perl  \
			python2 python3 gdb wireguard  resolvconf ripgrep

	tar xf ./dl/global-6.6.11.tar.gz -C ./
	cd global-6.6.11
	./configure --prefix=/usr && make -j4 && make install
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
