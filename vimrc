"" Last Change: 2012年 05月 12日 星期四 07:05:37 CST

"" 判断系统是否具有“自动命令”（autocmd）的支持
if has('autocmd')
  " 清除所有的自动命令，以方便调试
  au!
endif

"" Pathogen 插件管理
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""call system("notify-send " . v:version)

"" 载入文件类型插件
filetype plugin on

"" 为特定文件类型载入相关缩进文件
filetype indent on

colorscheme diablo3

"" Vim 会在自动补全文件名的时候，用斜杠代替反斜杠
set shellslash

"" 语法样式开启
syntax on

"" 设置字体
set guifont="Menlo"

"" 当使用了图形界面，并且环境变量 LANG 中不含“.”（即没有规定编码）时，把 Vim 的内部编码设为 UTF-8
"" set encoding=utf-8

"" 设置缩进
set sw=2
set ts=2
set softtabstop=2
set expandtab

"" 设置模板
let g:template_load = 1
let g:template_tags_replacing = 1
let g:T_AUTHOR = "Vayn a.k.a. VT"
let g:T_AUTHOR_EMAIL = "vayn@vayn.de"
let g:T_AUTHOR_WEBSITE = "http://elnode.com"
let g:T_DATE_FORMAT = "%c"

"" history文件中需要记录的行数
set history=1000

"" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

"" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *.txt setlocal ft=txt
au BufRead,BufNewFile *  setfiletype txt

"" 不需要保持和 vi 非常兼容
set nocompatible

"" 执行 Vim 缺省提供的 .vimrc 文件的示例，包含了打开语法加亮显示等最常用的功能
"" source $VIMRUNTIME/vimrc_example.vim

"" 使backspace正常处理indent, eol, start等
set backspace=indent,eol,start whichwrap+=<,>,[,]

"" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

"" 在输入命令时列出匹配项目
set wildmenu
set wildmode=list:longest

"" 打开自动缩,继承前一行的缩进注释进
set autoindent

"" 默认情况下手动折叠 foldmethod
set fdm=syntax
set foldclose=all

"" 显示行号（否：nonumber）
set number

"" changes line number column to display how far away each line is from the
"" current one (Vim 7.3 feature)
set relativenumber

"" create <FILENAME>.un~ files whenever you edit a file, undo previous actions
"" even after you close and reopen a file.
set undofile
set undodir=~/.vim/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"" 在终端输出一个相对平滑的更新
set ttyfast

"" 显示光标的坐标
set ruler

"" Backups
set backupdir=~/.vim/tmp/backup " backups
set directory=~/.vim/tmp/swap   " swap files
set backup            " enable backups
""set noswapfile

"" set bufhidden=hide

"" 在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
set showmatch

"" 匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>

"" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1

"" 搜索时不区分大小写
"" set ignorecase

"" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

"" 搜索高亮
set hlsearch

"" 不要闪烁
set novisualbell

"" 正确地处理中文字符的折行和拼接
set formatoptions+=mM

"" 文件 UTF-8 编码
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
  set fileencoding=chinese
else
  set fileencoding=utf-8
endif
source $VIMRUNTIME/delmenu.vim
language messages zh_CN.utf-8

"" 设置文件格式为unix
set fileformat=unix

"" 开启命令显示
set showcmd

"" 设置窗口大小
set lines=30
set columns=85
set textwidth=79

"" 自动换行
set wrap dy=lastline

"" 初始窗口的位置
""winpos 252 42

"" 行间距
set linespace=4

"" 启动的时候不显示intro
set shortmess=atI

"" 导出 html 设置
let html_use_css = 1
let html_number_lines = 0
let use_xhtml = 1

"" 隐藏底部滚动条
set guioptions-=b

"" 隐藏右边滚动条
set guioptions-=R
set guioptions-=r

"" 隐藏左边滚动条
set guioptions-=l
set guioptions-=L

"" 隐藏菜单和
set guioptions-=m

"" 隐藏工具栏
set guioptions-=T

"" 设置工作目录
function! CHANGE_CURR_DIR()
  let _dir = escape(expand("%:p:h"),' ')
  exec "cd " . _dir
  unlet _dir
endfunction
autocmd BufEnter * call CHANGE_CURR_DIR()

"" NERDTree插件的快捷键
imap <silent> <F7> <esc>:NERDTreeToggle<CR>
nmap <silent> <F7> :NERDTreeToggle<CR>
"" BufExplorer 快捷键 {{{
imap <silent> <F8> <esc>:BufExplorer<CR>
nmap <silent> <F8> :BufExplorer<CR>
"" }}}

"" Taglist shortcuts
imap <silent> <F9> <esc>:TlistToggle<CR>
nmap <silent> <F9> :TlistToggle<CR>

"" 窗口区域切换,F5 后 ↑↓←→  来切换
imap <silent> <C-left> <esc><C-W><left>
vmap <silent> <C-left> <esc><C-W><left>
nmap <silent> <C-left> <C-W><left>
imap <silent> <C-right> <esc><C-W><right>
vmap <silent> <C-right> <esc><C-W><right>
nmap <silent> <C-right> <C-W><right>
imap <silent> <C-up> <esc><C-W><up>
vmap <silent> <C-up> <esc><C-W><up>
nmap <silent> <C-up> <C-W><up>
imap <silent> <C-down> <esc><C-W><down>
vmap <silent> <C-down> <esc><C-W><down>
nmap <silent> <C-down> <C-W><down>

"" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

"" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

nnoremap <BS> d

"" ctrl + c
vmap <C-c> "+y
"" 把缺省的Ctrl – X + O 改为 F4
imap <F4> <C-X><C-O>
"" ctrl + x
vmap <C-x> "+x

"" ctrl + v
nnoremap <C-v> "+gP
""inoremap <C-v> <C-O>"+gP
"" ctrl + r
imap <C-h> <esc>:%s/
vmap <C-h> <esc>:%s/
nmap <C-h> :%s/

"" 使用 colorpicker 程序获取颜色值(hex/rgba)
inoremap <M-c> <C-R>=Lilydjwg_colorpicker()<CR>
nmap cac :call Lilydjwg_changeColor()<CR>

"" map leader to comma(default is backslash)
let mapleader = ","

"" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"" imitates TextMates Ctrl+Q function to re-hardwrap paragraphs of text
nnoremap <leader>q gqip

"" CSS properties sorted
nnoremap <leader>S /{<CR>jV/^\s*\}\?$<CR>k:sort<CR>:noh<CR>

"" Edit vim stuff.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.vim/snippets/<cr>

"" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" Rainbows!
nmap <leader>r :RainbowParenthesesToggle<CR>

"" Ack
map <leader>a :Ack


"" Display Highlight Group
nnoremap wh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


"" 括号和引号补全 {{{
""inoremap ( ()<ESC>i
inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
""inoremap { {}<ESC>i
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
""inoremap [ []<ESC>i
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
""inoremap < <><ESC>i
inoremap < <c-r>=OpenPair('<')<CR>
inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
  let PAIRs = {
        \ '{' : '}',
        \ '[' : ']',
        \ '(' : ')',
        \ '<' : '>'
        \}
  let ol = len(split(getline('.'), a:char, 1))-1
  let cl = len(split(getline('.'), PAIRs[a:char], 1))-1
  if ol==cl
    return a:char . PAIRs[a:char] . "\<Left>"
  else
    return a:char
  endif
endfunction
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
  let ql = len(split(getline('.'), a:quote, 1))-1
  " a:quote length is odd.
  if (ql%2)==1
    return a:quote
  elseif getline('.')[col('.') - 1] == a:quote
    return "\<Right>"
  else
    return a:quote . a:quote . "\<Left>"
  endif
endfunction
"" }}}

"" 自动打开或关闭fcitx
autocmd InsertLeave * set imdisable
autocmd InsertLeave * set noimdisable

"" CSS3 语法支持
au BufRead,BufNewFile *.css set ft=css syntax=css3

au BufNewFile,BufRead *.m*down set filetype=markdown
au BufNewFile,BufRead *.m*down nnoremap <leader>1 yypVr=
au BufNewFile,BufRead *.m*down nnoremap <leader>2 yypVr-
au BufNewFile,BufRead *.m*down nnoremap <leader>3 I### <ESC>

au BufNewFile,BufRead *.vim set foldmethod=marker

"" Make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV
"" ci[ 删除一对 [] 中的所有字符并进入插入模式
"" ci( 删除一对 () 中的所有字符并进入插入模式
"" ci< 删除一对 <> 中的所有字符并进入插入模式
"" ci{ 删除一对 {} 中的所有字符并进入插入模式
"" cit 删除一对 HTML/XML 的标签内部的所有字符并进入插入模式
"" ci” ci’ ci` 删除一对引号字符 (” 或 ‘ 或 `) 中所有字符并进入插入模式

"" 让选中内容变成搜索项
vnoremap <Leader># "9y?<C-R>='\V'.substitute(escape(@9,'\?'),'\n','\\n','g')<CR><CR>
vnoremap <Leader>* "9y/<C-R>='\V'.substitute(escape(@9,'\/'),'\n','\\n','g')<CR><CR>

"" 检查当前文件代码语法(php){{{
function! CheckSyntax()
  if &filetype!="php"
    echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
    return
  endif
  if &filetype=="php"
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
au filetype php map <F6> :call CheckSyntax()<CR>
"" }}}

"" php字典补全
if has("win32")
  au FileType php setlocal dict+=$VIM/vimfiles/dict/php_funclist.txt
else
  au FileType php setlocal dict+=~/.vim/dict/php_funclist.txt
endif

"" Python 补全
if has("win32")
  let g:pydiction_location = '$VIM/vimfiles/ftplugin/pydiction/complete-dict'
else
  let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'
endif
let g:pydiction_menu_height = 20

"" 自动在退出编辑模式（InsertLeave）时保存 php 和 python 文件
"" au InsertLeave *.php write
"" au InsertLeave *.py write

"" 开启 python 语法高亮
let python_highlight_all = 1

"" zencoding 设置
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

"" gVim Fullscreen
if has('gui_running') && has("win32")
  map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  imap <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

"" Ack can be used as a replacement for 99% of the uses of grep.
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"" 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Show_One_File = 1
"" 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1


"" Use neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

"" Use underbar completion
let g:neocomplcache_enable_underbar_completion = 1 

"" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

"" Recommended key-mappings.
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#smart_close_popup()

"" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"" }}}

"" PHPDoc conform document generator {{{
au FileType php source ~/.vim/plugin/php-doc.vim 
au FileType php inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
au FileType php nnoremap <C-P> :call PhpDocSingle()<CR> 
au FileType php vnoremap <C-P> :call PhpDocRange()<CR>
"" }}}

"" mru {{{
if has("win32") || has("win64")
  let MRU_File = '$VIM/vimfiles/vim_mru_files'
else
  let MRU_File = '~/.vim/tmp/mru_files'
endif
let MRU_Max_Entries = 2000
let MRU_Exclude_Files = '\v^.*\~$|/COMMIT_EDITMSG$|/itsalltext/|^/tmp/'
"  加载菜单太耗时
let MRU_Add_Menu = 0
"" }}}

"" make
autocmd FileType cpp,c nmap <leader>m :make<CR> :copen<CR> <C-W>10_
"" simple compile
autocmd FileType c nmap <F10> :w<cr>:exe ":set makeprg=gcc\\\ -std=gnu99\\\ -lm\\\ -Wall\\\ -o\\\ ".expand("%:r").".bin\\\ ".expand("%")<cr>:make<cr><cr>:cw<cr>
"" execute bin which is compiled by source
autocmd FileType cpp,c nmap <F5> :exe "!./".expand("%:r").".bin"<Left>

"" Windows 默认保存位置
if has('gui_running') && has("win32")
  cd D:\360data\重要数据\桌面
endif

"" Twitvim
let twitvim_enable_python = 1
