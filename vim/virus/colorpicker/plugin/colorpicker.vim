" 取得光标处的匹配
function Lilydjwg_get_pattern_at_cursor(pat)
  let col = col('.') - 1
  let line = getline('.')
  let ebeg = -1
  let cont = match(line, a:pat, 0)
  while (ebeg >= 0 || (0 <= cont) && (cont <= col))
    let contn = matchend(line, a:pat, cont)
    if (cont <= col) && (col < contn)
      let ebeg = match(line, a:pat, cont)
      let elen = contn - ebeg
      break
    else
      let cont = match(line, a:pat, contn)
    endif
  endwhile
  if ebeg >= 0
    return strpart(line, ebeg, elen)
  else
    return ""
  endif
endfunction
" 使用 colorpicker 程序获取颜色值(hex/rgba)[[[2
function! Lilydjwg_colorpicker()
  if exists("g:last_color")
    let color = substitute(system("colorpicker ".shellescape(g:last_color)), '\n', '', '')
  else
    let color = substitute(system("colorpicker"), '\n', '', '')
  endif
  if v:shell_error == 1
    return ''
  elseif v:shell_error == 2
    " g:last_color 值不对
    unlet g:last_color
    return Lilydjwg_colorpicker()
  else
    let g:last_color = color
    return color
  endif
endfunction
" 更改光标下的颜色值(hex/rgba/rgb)[[[2
function! Lilydjwg_changeColor()
  let color = Lilydjwg_get_pattern_at_cursor('\v\#[[:xdigit:]]{6}(\D|$)@=|<rgba\((\d{1,3},\s*){3}[.0-9]+\)|<rgb\((\d{1,3},\s*){2}\d{1,3}\)')
  if color == ""
    echohl WarningMsg
    echo "No color string found."
    echohl NONE
    return
  endif
  let g:last_color = color
  call Lilydjwg_colorpicker()
  exe 'normal eF'.color[0]
  call setline('.', substitute(getline('.'), '\%'.col('.').'c\V'.color, g:last_color, ''))
endfunction

" inoremap <M-c> <C-R>=Lilydjwg_colorpicker()<CR>
" nmap cac :call Lilydjwg_changeColor()<CR>
