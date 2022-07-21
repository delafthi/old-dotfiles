" VHDL indent ('93 syntax)
" Language:    VHDL
" Maintainer:  Thierry Delafontaine (delafontaineth@pm.me)
" Version:     1.0
" Last Change: 2022 Jul 20

" only load this indent file when no other was loaded
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" setup indent options for local VHDL buffer
setlocal indentexpr=GetVHDLIndent()

" Change the default indentkeys. Removed 0{,0},0],:,0#, and e, since the else
" statement will be included below (due to the possibility of capital letters
" for keywords)
setlocal indentkeys=0),!^F,o,O

" To make Vim call GetVHDLIndent() when it finds 'begin', 'end'
" 'then', '\*else', 'loop' or 'case' (for the end case statement) on the current line.
setlocal indentkeys+=0=~begin,0=~end,0=~elsif,0=~else,0=~when,=~case

setlocal autoindent

if exists("*GetVHDLindent")
  finish
endif

function! GetVHDLIndent()
  " Find a non-blank line above the current line.
  let prevlnum = prevnonblank(v:lnum - 1)

  " Hit the start of the file, use zero indent.
  if prevlnum == 0
    return 0
  endif

  " Add a 'shiftwidth' after lines that start a block: 'begin', 'for' '(', 'of', is',
  " 'generate', 'then', 'loop', 'when', 'function', 'procedure', 'units',
  " 'record', 'protected', 'constant', 'signal', 'variable', 'file', 'alias',
  " 'attribute', 'component', 'use', ':' '<=', ':='
  let ind = indent(prevlnum)
  let prevline = getline(prevlnum)
  let midx = match(prevline, '\%(^\s*begin\>\|^\s*for\>\|(\|\<of\>\|\<is\>\|\<generate\>\|\<then\>\|\<loop\>\|^\s*when\>\|\<function\>\|\<procedure\>\|^\s*units\>\|^\s*record\>\|^\s*protected\>\|^\s*constant\>\|^\s*signal\>\|^\s*variable\>\|^\s*file\>\|^\s*alias\>\|^\s*attribute\>\|^\s*component\>\|^\s*use\>\|:\|<=\|:=\)')


    if midx != -1
      " Add 'shiftwidth' if what we found previously is not in a comment and
      " an 'end' or ';' is not present on the same line.
      if synIDattr(synID(prevlnum, midx + 1, 1), "name") != "vhdlComment" && prevline !~ '\<end\>\|;'
        let ind = ind + shiftwidth()
      endif
    endif

    " Subtract a 'shiftwidth' on 'begin', 'end', 'elsif', 'else', 'when', ')'
    " and ';'.
    " This is the part that requires 'indentkeys'.
    let midx = match(getline(v:lnum), '^\s*\%(begin\>\|end\>\|elsif\>\|else\>\|when\>\|end\scase\>\|)\|;\)')
    if midx != -1 && synIDattr(synID(v:lnum, midx + 1, 1), "name") != "vhdlComment"
      let ind = ind - shiftwidth()
    endif

    return ind
  endfunction
