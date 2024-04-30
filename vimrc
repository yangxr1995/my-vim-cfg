set nocompatible
set cursorline      " 显示下划线

set completeopt=
syntax on	" 支持语法高亮
filetype plugin indent on " 根据文件类型自动缩进
set autoindent		" 开始新行处缩进
set tabstop=4		" tab的空格数
set shiftwidth=4	" 自动缩进的空格数
set backspace=2		" 修正backspce的行为

" let g:molokai_original = 1
" let g:rehash256 = 1
" colorscheme molokai

" colorscheme gruvbox
colorscheme sonokai
set t_Co=256
" set background=dark

nnoremap <S-Up> :resize -1<CR>
nnoremap <S-Down> :resize +1<CR>
nnoremap <S-Right> :vertical resize -1<CR>
nnoremap <S-Left> :vertical resize +1<CR>

set nobackup
set noswapfile
set autowrite
set autoread

set ignorecase
set hlsearch
set incsearch

set enc=utf-8

" 中文乱码
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030
set imcmdline
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

packloadall		        " 加载所有插件
silent! helptags ALL	" 加载所有插件帮助文档

imap ( ()<ESC>i
imap [ []<ESC>i
imap { {}<ESC>i

nmap <F1> :cclose<CR>zz

nmap * *N:set hls<CR>
nmap ** :set nohls<CR>

let g:termdebug_wide=1

" NERDTree config
map <F2> :NERDTreeToggle<CR>

" tagbar
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30

" easymotion
nmap ss <Plug>(easymotion-s2)

" coc
set nowritebackup
set updatetime=300
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function! s:goto_tag(tagkind) abort
  let tagname = expand('<cWORD>')
  let winnr = winnr()
  let pos = getcurpos()
  let pos[0] = bufnr()

  if CocAction('jump' . a:tagkind)
    call settagstack(winnr, {
      \ 'curidx': gettagstack()['curidx'],
      \ 'items': [{'tagname': tagname, 'from': pos}]
      \ }, 't')
  endif
endfunction
nmap gd :call <SID>goto_tag("Definition")<CR>
nmap gi :call <SID>goto_tag("Implementation")<CR>
nmap gr :call <SID>goto_tag("References")<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 禁用vim 自带popup menu
" set completeopt-=menu
" set pumheight=10

" gutentags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = ['gtags_cscope']
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/LeaderF/gtags')
let g:gutentags_plus_switch = 1
" let g:gutentags_trace = 1
let g:gutentags_auto_add_gtags_cscope = 1
let g:gutentags_plus_nomap = 1
let g:gutentags_generate_on_write = 0
nmap <F3> :GutentagsUpdate<CR>zz
" 找符号
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" 找符号的定义 
noremap <silent> <leader>gd :GscopeFind g <C-R><C-W><cr>
" 找函数调用出
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" 找文本字符串
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" 找文件
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" 哪些文件include了本文将
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" 找变量的赋值处
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

" Preview
noremap pp :PreviewQuickfix<cr><cr>
noremap PP :PreviewClose<cr><cr>

" gtags
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
" gtags.vim 设置项
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" nmap gu :AsyncRun gtags --incremental<CR>
" nmap gf :AsyncRun gtags --incremental -f ./gtags-list<CR>
"---------------------------------------------------------

" Leaderf
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
"" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"

"" Show icons, icons are shown by default
let g:Lf_ShowDevIcons = 1
" For GUI vim, the icon font can be specify like this, for example
let g:Lf_DevIconsFont = "DroidSansM Nerd Font Mono"
"" If needs
set ambiwidth=double

noremap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>

noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf gtags %s", "")<CR><CR>

"" should use `Leaderf gtags --update` first
"let g:Lf_GtagsAutoUpdate = 1

" minibufexpl
noremap <leader>1 :b1<CR>
noremap <leader>2 :b2<CR>
noremap <leader>3 :b3<CR>
noremap <leader>4 :b4<CR>
noremap <leader>5 :b5<CR>
noremap <leader><Space> :MBEbn<CR>
noremap <leader><Tab><Space> :MBEbp<CR>

let g:Lf_RootMarkers = ['.root', '.svn', '.git', '.hg', '.project']

let g:miniBufExplMaxSize = 3

" codeium
let g:codeium_bin = '/usr/bin/language_server_linux_x64'
let g:codeium_idle_delay = 50 
let g:codeium_render = v:true

let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <Tab> codeium#Accept()
imap <Left>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <Right>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <Down>   <Cmd>call codeium#Clear()<CR>

" let g:codeium_manual = v:true

" You might want to use `CycleOrComplete()` instead of `CycleCompletions(1)`.
" This will make the forward cycling of suggestions also trigger the first
" suggestion manually.
imap <C-l> <Cmd>call codeium#CycleOrComplete()<CR>

set nocul
" hi Normal guibg=NONE ctermbg=NONE
