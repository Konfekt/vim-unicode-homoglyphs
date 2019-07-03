scriptencoding utf-8

" LICENCE PUBLIQUE RIEN À BRANLER
" Version 1, Mars 2009
"
" Copyright (C) 2009 Sam Hocevar
" 14 rue de Plaisance, 75014 Paris, France
"
" La copie et la distribution de copies exactes de cette licence sont
" autorisées, et toute modification est permise à condition de changer
" le nom de la licence.
"
" CONDITIONS DE COPIE, DISTRIBUTON ET MODIFICATION
" DE LA LICENCE PUBLIQUE RIEN À BRANLER
"
" 0. Faites ce que vous voulez, j’en ai RIEN À BRANLER.

if exists('g:loaded_homoglyphs') || &cp
  finish
endif
let g:loaded_homoglyphs = 1

let s:keepcpo         = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

command! -range=% -bar NormalizeHomoglyphs call homoglyphs#normalize(<line1>, <line2>)

nnoremap <silent> <plug>(NormalizeHomoglyphs) :<C-U>set opfunc=homoglyphs#normalize<CR>g@
xnoremap <silent> <plug>(NormalizeHomoglyphs) :<C-U>call homoglyphs#normalize("'<", "'>")<CR>

if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'n')
  silent! nmap <unique> gy <plug>(NormalizeHomoglyphs)
endif
if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'x')
  silent! xmap <unique> gy <plug>(NormalizeHomoglyphs)
endif

if hasmapto('gy', 'n')
  onoremap <SID>(underline) _
  silent! nmap <unique><expr> gyy  'gy' . v:count1 . '<SID>(underline)'
  silent! nmap <unique>       gygy gyy
endif

if !exists('g:is_homoglyph_on') | let g:is_homoglyph_on = 1 | endif

if g:is_homoglyph_on == 1
  call homoglyphs#on()
else
  call homoglyphs#off()
endif

silent! nnoremap <unique><silent> <plug>(HighlightHomoglyphs) :<c-u>call homoglyphs#toggle()<CR>
if !hasmapto('<Plug>(HighlightHomoglyphs)', 'n')
  " Change Unicode
  silent! nmap <unique> cu <plug>(HighlightHomoglyphs)
endif

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
