" Last Change: 2011年 10月 08日 星期六 08:24:56 CST
scriptencoding utf-8

" 初始化 {{{1
" Vundle {{{2
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle *required 
Bundle 'gmarik/vundle'

" From github {{{3
Bundle 'Shougo/vimproc.git'
Bundle 'Shougo/vimshell.git'
Bundle 'Vayn/Fanfou.git'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'bootleq/vim-cycle.git'
Bundle 'c9s/cascading.vim.git'
Bundle 'fs111/pydoc.vim.git'
Bundle 'godlygeek/tabular.git'
Bundle 'hail2u/vim-css3-syntax.git'
Bundle 'hallettj/jslint.vim.git'
Bundle 'lilydjwg/colorizer.git'
Bundle 'lilydjwg/lusty.git'
Bundle 'mileszs/ack.vim.git'
Bundle 'msanders/snipmate.vim.git'
Bundle 'nathanaelkane/vim-indent-guides.git'
Bundle 'pangloss/vim-javascript.git'
Bundle 'rphillips/vim-zoomwin.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'ujihisa/vimshell-ssh.git'
Bundle 'vim-scripts/CountJump.git'
Bundle 'vim-scripts/L9.git'
Bundle 'vim-scripts/cscope_macros.vim.git'
Bundle 'vim-scripts/sudo.vim.git'
" 3}}}
" 2}}}

" 自带设置 {{{2
runtime vimrc_example.vim
runtime macros/matchit.vim
" 2}}}

" 工作目录 {{{2
function! CHANGE_CURR_DIR()
  let _dir = escape(expand("%:p:h"),' ')
  exec "cd " . _dir
  unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()
" 2}}}

" 模板 {{{2
let g:template_load = 1
let g:template_tags_replacing = 1
let g:T_AUTHOR = "Vayn a.k.a. VT"
let g:T_AUTHOR_EMAIL = "vayn@vayn.de"
let g:T_AUTHOR_WEBSITE = "http://elnode.com"
let g:T_DATE_FORMAT = "%c"
" 2}}}

" Python 高亮
let python_highlight_all = 1
" 打开 JS 对 DOM、HTML 和 CSS 的支持
let javascript_enable_domhtmlcss=1
" 导出 HTML 设置
let html_use_css = 1
let html_number_lines = 0
let use_xhtml = 1
" 1}}}

" 常规设置 {{{1
" Unix 风格 slash
set shellslash
" history 文件记录行数
set history=1000

" 备份
set backup
set backupdir=~/.vim/tmp/backup " backups
set directory=~/.vim/tmp/swap   " swap files
"set noswapfile

set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000 "max number lines to save for undo on a buffer reload

" 允许backspace和光标键跨越行边界
set whichwrap=b,s,[,],h,l
" 搜索时不区分大小写
set ignorecase
" 搜索高亮
set hlsearch
" 当前 buffer 可放在 bg 而不用写入磁盘
set hidden
" 禁止在选择补全时打开 privew 窗口显示文档信息。针对 python omnicomplete（太扰
" 民了）
set completeopt-=preview

set isfname-==
set noequalalways
set winaltkeys=no
set completeopt+=longest
set cedit=<C-Y>
" 1}}}

" 格式设置 {{{1
" 编码 {{{2
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
  set fileencoding=chinese
else
  set fileencoding=utf-8
endif
language messages zh_CN.utf-8
" 2}}}

" 正确地处理中文字符的折行和拼接
set formatoptions+=mM
" 设置文件格式为unix
set fileformat=unix

" 缩进
set shiftwidth=2
set tabstop=2
set softtabstop=2
" 行间距
set linespace=4
set expandtab

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 使backspace正常处理indent, eol, start等
set backspace=indent,eol,start
" 在输入命令时列出匹配项目
set wildmenu
set wildmode=list:longest
" 1}}}

" 显示设置 {{{1
" 字体
set guifont=inconsolata-dz\ 11

" 窗口及主题设置 {{{2
if has('gui_running')
  "" 有些终端不能改变大小 http://vayn.de/qF7u2c
  set lines=30      " 终端出现断裂的原因
  set columns=85

  set background=dark
  colorscheme solarized
else
  set ambiwidth=single
  colorscheme lemon256
endif
" 2}}}

" 高亮光标所在行
set cursorline
" 使用相对行号
set relativenumber
" 在终端输出一个相对平滑的更新
set ttyfast
" 在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
set showmatch
" 匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 不要闪烁
set novisualbell
set listchars=eol:$,tab:>-,nbsp:~
" 自动关闭折叠
set foldclose=all
" 显示窗口末行尽量多的内容
set display=lastline
" 自动回绕
set nolinebreak
" 启动的时候不显示intro
set shortmess=atI
" 屏幕保留行数
set scrolloff=5

" 隐藏底部滚动条
set guioptions-=b
" 隐藏右边滚动条
set guioptions-=R
set guioptions-=r
" 隐藏左边滚动条
set guioptions-=l
set guioptions-=L
" 隐藏菜单和工具栏
set guioptions-=m
set guioptions-=T

" Avoid cmdline redraw on every entered char by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
  set noarabicshape
endif

if has("conceal")
  set concealcursor=nc
  set maxcombine=4
endif
" 1}}}

" 键映射 {{{1
" 回车取消搜索高亮
nnoremap <silent> <CR> :nohl<CR>

" 窗口区域切换 ←→↑↓
imap <silent> `h <esc><C-W><left>
vmap <silent> `h <esc><C-W><left>
nmap <silent> `h <C-W><left>
imap <silent> `l <esc><C-W><right>
vmap <silent> `l <esc><C-W><right>
nmap <silent> `l <C-W><right>
imap <silent> `k <esc><C-W><up>
vmap <silent> `k <esc><C-W><up>
nmap <silent> `k <C-W><up>
imap <silent> `j <esc><C-W><down>
vmap <silent> `j <esc><C-W><down>
nmap <silent> `j <C-W><down>

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Display Highlight Group
nnoremap wh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <BS> d

" 跳转搜索结果时，其所在行居中并闪烁
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>

" ctrl + c
vmap <C-c> "+y
" ctrl + x
vmap <C-x> "+x
" ctrl + v
nnoremap <C-v> "+gP
" ctrl + h
imap <C-h> <esc>:%s/
vmap <C-h> <esc>:%s/
nmap <C-h> :%s/

" 把缺省的Ctrl – X + O 改为 F4
imap <F4> <C-X><C-O>

" Make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV
" ci[ 删除一对 [] 中的所有字符并进入插入模式
" ci( 删除一对 () 中的所有字符并进入插入模式
" ci< 删除一对 <> 中的所有字符并进入插入模式
" ci{ 删除一对 {} 中的所有字符并进入插入模式
" cit 删除一对 HTML/XML 的标签内部的所有字符并进入插入模式
" ci” ci’ ci` 删除一对引号字符 (” 或 ‘ 或 `) 中所有字符并进入插入模式

" 交换历史移动键位，键位作用参见 cmdline.txt
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <Up> <C-P>
cnoremap <Down> <C-N>

" Leader mappings {{{2
let mapleader = ","

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" imitates TextMates Ctrl+Q function to re-hardwrap paragraphs of text
nnoremap <leader>q gqip
" CSS properties sorted
nnoremap <leader>S /{<CR>jV/^\s*\}\?$<CR>k:sort<CR>:noh<CR>

" Edit vim stuff.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.vim/bundle/snipmate/snippets/<cr>

" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" 让选中内容变成搜索项
vnoremap <Leader># "9y?<C-R>='\V'.substitute(escape(@9,'\?'),'\n','\\n','g')<CR><CR>
vnoremap <Leader>* "9y/<C-R>='\V'.substitute(escape(@9,'\/'),'\n','\\n','g')<CR><CR>
" 2}}}
" 1}}}

" 命令 {{{1
" 设默认 filetype 为 txt
autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif

" Make
autocmd FileType cpp,c nmap <leader>m :make<CR> :copen<CR> <C-W>10_
" simple compile
autocmd FileType c nmap <F10> :w<cr>:exe ":set makeprg=gcc\\\ -std=gnu99\\\ -lm\\\ -Wall\\\ -o\\\ ".expand("%:r").".bin\\\ ".expand("%")<cr>:make<cr><cr>:cw<cr>
" execute bin which is compiled by source
autocmd FileType cpp,c nmap <F11> :exe "!./".expand("%:r").".bin"<Left>
" 1}}}

" 函数 {{{1
" 检查 PHP 语法 {{{2
function! CheckSyntax()
  if &FileType!="php"
    echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
    return
  endif
  if &FileType=="php"
    " Check php syntax
    setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
    " Set shellpipe
    setlocal shellpipe=>
    " Use error format for parsing PHP error output
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  endif
  execute "silent make %"
  set makeprg=make
  execute "normal :"
  execute "copen"
endfunction
autocmd FileType php map <F6> :call CheckSyntax()<CR>
" }}}

" PHP 字典 {{{2
if has("win32")
  au FileType php setlocal dict+=$VIM/vimfiles/dict/php_funclist.txt
else
  au FileType php setlocal dict+=~/.vim/dict/php_funclist.txt
endif
" 2}}}

" Pulse {{{2
" 来自 http://vayn.de/tUAYAK
function! PulseCursorLine()
  let current_window = winnr()

  windo set nocursorline
  execute current_window . 'wincmd w'

  setlocal cursorline

  redir => old_hi
    silent execute 'hi CursorLine'
  redir END
  let old_hi = split(old_hi, '\n')[0]
  let old_hi = substitute(old_hi, 'xxx', '', '')

  hi CursorLine guibg=#2a2a2a ctermbg=233
  redraw
  sleep 20m

  hi CursorLine guibg=#333333 ctermbg=235
  redraw
  sleep 20m

  hi CursorLine guibg=#3a3a3a ctermbg=239
  redraw
  sleep 20m

  hi CursorLine guibg=#444444 ctermbg=240
  redraw
  sleep 20m

  hi CursorLine guibg=#4a4a4a ctermbg=242
  redraw
  sleep 20m

  hi CursorLine guibg=#444444 ctermbg=240
  redraw
  sleep 20m

  hi CursorLine guibg=#3a3a3a ctermbg=239
  redraw
  sleep 20m

  hi CursorLine guibg=#333333 ctermbg=235
  redraw
  sleep 20m

  hi CursorLine guibg=#2a2a2a ctermbg=233
  redraw
  sleep 20m
  
  execute 'hi ' . old_hi

  windo set cursorline
  execute current_window . 'wincmd w'
endfunction
" 2}}}
" 1}}}

" 插件 {{{1
" Gundo
Bundle 'sjl/gundo.vim.git'
nnoremap <F5> :GundoToggle<CR>

" zencoding {{{2
Bundle 'vim-scripts/ZenCoding.vim.git'
let g:user_zen_settings = {
 \ 'php' : {
 \  'extends' : 'html',
 \  'filters' : 'c',
 \  },
 \  'xml' : {
 \  'extends' : 'html',
 \  },
 \  'haml' : {
 \  'extends' : 'html',
 \  },
 \  'snippets' : {
 \  'use' : "use strict\nuse warnings\n\n",
 \  'warn' : "warn \"|\";",
 \  }
\}
let g:user_zen_expandabbr_key = '<c-e>'  "设置为ctrl+e展开
let g:use_zen_complete_tag = 1
" 2}}}

" neocomplcache {{{2
Bundle 'Shougo/neocomplcache.git'
let g:neocomplcache_enable_at_startup = 1

" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#smart_close_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" 2}}}

" VimRoom {{{2
Bundle 'Vayn/vimroom.git'
let g:vimroom_navigation_keys = 0
let g:vimroom_sidebar_height = 0
let g:vimroom_guibackground = '#002b36'
let g:vimroom_ctermbackground = 8
nmap <silent> <leader>v <Plug>VimroomToggle
" 2}}}

" pyflakes
Bundle 'nvie/vim-pyflakes.git'
autocmd FileType python map <buffer> <F2> :call Pyflakes()<CR>

" pep8
Bundle 'nvie/vim-pep8.git'
let g:pep8_args = "--ignore=E111"
autocmd FileType python map <buffer> <F3> :call Pep8()<CR>

" NERDTree插件的快捷键
Bundle 'scrooloose/nerdtree.git'
imap <silent> <F7> <esc>:NERDTreeToggle<CR>
nmap <silent> <F7> :NERDTreeToggle<CR>

" Tagbar 设置
Bundle 'majutsushi/tagbar.git'
imap <silent> <F9> <esc>:TagbarToggle<CR>
nmap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30

" 启动 pathogen 
call pathogen#infect('virus')

" Rainbows
nmap <leader>r :RainbowParenthesesToggle<CR>

" 使用 colorpicker 获取颜色值(hex/rgba)
inoremap <M-c> <C-R>=Lilydjwg_colorpicker()<CR>
nmap cac :call Lilydjwg_changeColor()<CR>

" QuickBuf 快捷键
let g:qb_hotkey = "<F8>"

" PHPDoc conform document generator {{{2
autocmd FileType php runtime plugin/php-doc.vim 
autocmd FileType php inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
autocmd FileType php nnoremap <C-P> :call PhpDocSingle()<CR> 
autocmd FileType php vnoremap <C-P> :call PhpDocRange()<CR>
" 2}}}

" mru {{{2
if has("win32") || has("win64")
  let MRU_File = '$VIM/vimfiles/vim_mru_files'
else
  let MRU_File = '~/.vim/tmp/mru_files'
endif
let MRU_Max_Entries = 2000
let MRU_Exclude_Files = '\v^.*\~$|/COMMIT_EDITMSG$|/itsalltext/|^/tmp/'
" 加载菜单太耗时
let MRU_Add_Menu = 0
" 2}}}

" vim:fdm=marker
