" Define colors {{{1
let s:red          = ['#e06c75', '4']   
let s:green        = ['#98c379', '2']   
let s:orange       = ['#e59F70', '130'] 
let s:yellow       = ['#e5c07b', '6']   
let s:blue         = ['#61afef', '1']   
let s:purple       = ['#c678dd', '5']   
let s:cyan         = ['#56b6c2', '3']   

let s:red_dark     = ['#be646a', '88']  
let s:green_dark   = ['#7e9d69', '22']  
let s:orange_dark  = ['#c08768', '130'] 
let s:yellow_dark  = ['#bd9e6f', '136'] 
let s:blue_dark    = ['#5f96c9', '62']  
let s:purple_dark  = ['#a86cbb', '97'] 
let s:cyan_dark    = ['#51969f', '66']  

let s:red_light    = ['#e8838c', '12']  
let s:green_light  = ['#a6d18c', '10']  
let s:orange_light = ['#ecb07e', '173'] 
let s:yellow_light = ['#eccd84', '14']  
let s:blue_light   = ['#75c2f3', '9']   
let s:purple_light = ['#d38de6', '13']  
let s:cyan_light   = ['#69c7d1', '11']  

let s:black        = ['#282c34', '0']
let s:white        = ['#dcdfe4', '15']

let s:mono1        = ['#313640', '16']
let s:mono2        = ['#4b5263', '59']
let s:mono3        = ['#5c6370', '59']
let s:mono4        = ['#919baa', '245']
let s:mono5        = ['#abb2bf', '145']

let s:none = ''

" Helper functions {{{1
" From rakr/vim-one
function! <Sid>X(group, fg, bg, attr, ...)
  let l:attrsp = get(a:, 1, "")
  " fg, bg, attr, attrsp
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" .  a:fg[0]
    exec "hi " . a:group . " ctermfg=" . a:fg[1]
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" .  a:bg[0]
    exec "hi " . a:group . " ctermbg=" . a:bg[1]
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" .   a:attr
    exec "hi " . a:group . " cterm=" . a:attr
  endif
  if !empty(l:attrsp)
    exec "hi " . a:group . " guisp=" . l:attrsp[0]
  endif
endfunction

function! SetMode(mode)
  if a:mode == 'n'
    call <Sid>X('StatusLineMode' , s:black , s:green , 'none')
    let l:modeString = 'NORMAL'
  elseif a:mode == 'i'
    call <Sid>X('StatusLineMode' , s:black , s:blue , 'none')
    let l:modeString = 'INSERT'
  elseif a:mode == 'c'
    call <Sid>X('StatusLineMode' , s:black , s:red , 'none')
    let l:modeString = 'COMMAND'
  elseif a:mode == 't'
    call <Sid>X('StatusLineMode' , s:black , s:orange , 'none')
    let l:modeString = 'TERMINAL'
  elseif a:mode == 'v'
    call <Sid>X('StatusLineMode' , s:black , s:yellow , 'none')
    let l:modeString = 'VISUAL'
  elseif a:mode == 'V'
    call <Sid>X('StatusLineMode' , s:black , s:yellow , 'none')
    let l:modeString = 'V-LINE'
  elseif a:mode == ''
    call <Sid>X('StatusLineMode' , s:black , s:yellow , 'none')
    let l:modeString = 'V-BLOCK'
  elseif a:mode == 'R'
    call <Sid>X('StatusLineMode' , s:black , s:purple , 'none')
    let l:modeString = 'REPLACE'
  elseif a:mode == 's'
    call <Sid>X('StatusLineMode' , s:black , s:red , 'none')
    let l:modeString = 'SELECT'
  elseif a:mode == 'S'
    call <Sid>X('StatusLineMode' , s:black , s:red , 'none')
    let l:modeString = 'S-LINE'
  elseif a:mode == ''
    call <Sid>X('StatusLineMode' , s:black , s:red , 'none')
    let l:modeString = 'S-BLOCK'
  else
    call <Sid>X('StatusLineMode' , s:black , s:red , 'none')
    let l:modeString = 'UNKNOWN'
  endif
  return l:modeString
endfunction

function! StatuslineModified()
  if getbufinfo()[0].changed
    let l:sl = ' [+] '
  else
    let l:sl = ''
  endif
  return l:sl
endfunction

function! StatuslineReadOnly()
  if &readonly || !&modifiable
    let s:sl = ' [RO] '
  else
    let s:sl = ''
  endif
  return s:sl
endfunction

function! GetGitBranch()
  
  " return system('git branch --show-current 2>/dev/null')
  return 'branch'
endfunction
  


" Setup function {{{1
function statusline#setup()
  " Theming
  call <Sid>X('StatusLineMode'       , s:black , s:red   , 'none')
  call <Sid>X('StatusLineFileType'   , s:mono3 , s:mono1 , 'none')
  call <Sid>X('StatusLineFileName'   , s:white , s:mono1 , 'none')
  call <Sid>X('StatusLineReadOnly'   , s:red   , s:mono1 , 'none')
  call <Sid>X('StatusLineModified'   , s:red   , s:mono1 , 'none')
  call <Sid>X('StatusLineGitBranch'  , s:mono3 , s:mono1 , 'none')
  call <Sid>X('StatusLineSeparator'  , s:blue  , s:mono1 , 'none')
  call <Sid>X('StatusLinePercentage' , s:black , s:blue  , 'none')

  " Build statusline
  let s:slLinemode = '%#StatusLineMode# %{SetMode(mode())} '
  let s:slFiletype = '%#StatusLineFileType# %-Y '
  let s:slFilename = '%#StatusLineFileName# %-t '
  let s:slReadonly = '%#StatusLineReadOnly#%{StatuslineReadOnly()}'
  let s:slModified = '%#StatusLineModified#%{StatuslineModified()}'
  let s:slGitBranch = '%#StatusLineGitBranch#%{GetGitBranch()} '
  let s:slSeparator = '%#StatusLineSeparator#'
  let s:slPercentage = '%#StatusLinePercentage# %p%% '
  let s:slLeft = s:slLinemode.s:slFiletype.s:slFilename.s:slReadonly.s:slModified
  let s:slRight = s:slSeparator.s:slPercentage
  let &g:statusline = s:slLeft.'%*%='.s:slRight " Set statusline.
endfunction

" }}}
