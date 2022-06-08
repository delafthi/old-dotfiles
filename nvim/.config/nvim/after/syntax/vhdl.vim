" Match generics (G_) and constants (C_)
syn match vhdlConstant "\'\=\<C_\w\+\>"
syn match vhdlGeneric "\'\=\<G_\w\+\>"
" Match customs types (_t)
syn match vhdlType "\<\w\+_t\>\'\="

hi def link vhdlConstant Constant
hi def link vhdlGeneric Constant
hi def link vhdlType Type
