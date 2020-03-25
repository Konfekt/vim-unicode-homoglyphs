scriptencoding utf-8

function! homoglyphs#normalize(...) abort
  normal! m`

  if a:0 == 2
    let open  = a:1
    let close = a:2
  else
    let open  = "'["
    let close = "']"
  endif

  call s:normalize(open, close)

  normal! g``
endfunction

function! s:normalize(o,c) abort
  let o = a:o
  let c = a:c

  let gdefault = &gdefault
  set gdefault&
  for n in g:normalizations
    exe 'silent keeppatterns ' . o . ',' . c . 'substitute/' . '[' . n[1] . ']' . '/' . escape(n[0], '\/~&') . '/geI'
  endfor

  let &gdefault = gdefault
endfunction

function! homoglyphs#toggle() abort
  if g:is_homoglyph_on == 1
    call homoglyphs#off()
    echom 'Setting homoglyph highlight off'
  else
    call homoglyphs#on()
    echom 'Setting homoglyph highlight on'
  endif
endfunction

function! homoglyphs#off() abort
  if !g:is_homoglyph_on
    return
  endif

  augroup HighlightHomoglyphs
    autocmd!
  augroup end
  highlight homoglyphbg none
  highlight homoglyphfg none

  let g:is_homoglyph_on = 0
endfunction

function! homoglyphs#on() abort
  if g:is_homoglyph_on
    return
  endif

  call HomoglyphsOn()

  let g:is_homoglyph_on = 1
endfunction

