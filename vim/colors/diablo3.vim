" Vim color file
" Name:   diablo3.vim
" Author: Vayn <vayn@vayn.de>
" Note:   Based on molokai theme by Tomas Restrepo
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="diablo3"

hi Boolean         guifg=#ae81ff               gui=bold
hi Character       guifg=#e6db74
hi Number          guifg=#ae81ff
hi String          guifg=#fadc11
hi Conditional     guifg=#6d8fd9               gui=bold
hi Constant        guifg=#d4ff36               gui=bold
hi Cursor          guifg=#000000 guibg=#f8f8f0
hi Debug           guifg=#bca3a3               gui=bold
hi Define          guifg=#66d9ef
hi Delimiter       guifg=#8f8f8f
hi DiffAdd                       guibg=#13354a
hi DiffChange      guifg=#89807d guibg=#4c4745
hi DiffDelete      guifg=#960050 guibg=#1e0010
hi DiffText                      guibg=#4c4745 gui=italic,bold

hi Directory       guifg=#a6e22e               gui=bold
hi Error           guifg=#960050 guibg=#1e0010
hi ErrorMsg        guifg=#f92672 guibg=#232526 gui=bold
hi Exception       guifg=#a6e22E               gui=bold
hi Float           guifg=#ae81fF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#cbfe28
hi Identifier      guifg=#ff9900
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#c4be89 guibg=#000000

hi Keyword         guifg=#f92672               gui=bold
hi Label           guifg=#e6db74               gui=none
hi Macro           guifg=#c4be89               gui=italic
hi SpecialKey      guifg=#d3fe36               gui=italic

hi MatchParen      guifg=#000000 guibg=#fd971f gui=bold
hi ModeMsg         guifg=#e6db74
hi MoreMsg         guifg=#e6db74
hi Operator        guifg=#6d8fd9

" complete menu
hi Pmenu           guifg=#66d9ef guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66d9ef

hi PreCondit       guifg=#a6e22e               gui=bold
hi PreProc         guifg=#a6e22e
hi Question        guifg=#66d9ef
hi Repeat          guifg=#f92672               gui=bold
hi Search          guifg=#fffffF guibg=#0099ff
" marks column
hi SignColumn      guifg=#a6e22e guibg=#232526
hi SpecialChar     guifg=#f92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66d9ef guibg=bg      gui=italic
hi SpecialKey      guifg=#888A85               gui=italic
if has("spell")
    hi SpellBad    guisp=#ff0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70f0f0 gui=undercurl
    hi SpellRare   guisp=#ffffff gui=undercurl
endif
hi Statement       guifg=#6d8fd9               gui=bold
hi htmlStatement   guifg=#99b5d9
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#fd971f               gui=italic
hi Structure       guifg=#66d9ef
hi Tag             guifg=#f92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#ffffff guibg=bg      gui=bold

hi Typedef         guifg=#66d9ef
hi Type            guifg=#66d9ef               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403d3d
hi Visual                        guibg=#403d3d
hi WarningMsg      guifg=#ffffff guibg=#333333 gui=bold
hi WildMenu        guifg=#66d9ef guibg=#000000

hi Normal          guifg=#f4f4f4 guibg=#070914
hi Comment         guifg=#666666
hi CursorLine                    guibg=#293739
hi CursorColumn                  guibg=#293739
hi LineNr          guifg=#bcbcbc guibg=#151825
hi NonText         guifg=#151825 guibg=#151825 
" RoyalBlue #151825

hi LongLineWarning guifg=#960050 guibg=#1e0010 gui=underline
match LongLineWarning '\%121v.*' " Error format when a line is longer than 120

"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi Keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel                    ctermbg=244
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=253 ctermbg=66

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=232
   hi SpecialKey      ctermfg=245

   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Normal          ctermfg=252 ctermbg=233
   hi Comment         ctermfg=59
   hi CursorLine                  ctermbg=234   cterm=none
   hi CursorColumn                ctermbg=234
   hi LineNr          ctermfg=250 ctermbg=234
   hi NonText         ctermfg=250 ctermbg=234
end
