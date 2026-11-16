scriptencoding utf-8

" Return a list of regexes that together match each of the characters in
" a:chars.
"
" Each character is written as a code-point escape, so characters that are
" special inside a collection (such as - ] ^ \) are taken literally.
" Characters that Neovim treats as composing (such as U+200C and U+200D)
" are matched neither inside a collection nor as a branch of an
" alternation there, so each of them gets a pattern of its own.
function! homoglyphs#patterns(chars) abort
  let collection = ''
  let patterns = []
  for nr in str2list(a:chars)
    if strchars('a' . nr2char(nr), 1) == 1
      call add(patterns, printf('\m\C\%%U%08x', nr))
    else
      let collection .= printf('\U%08x', nr)
    endif
  endfor
  if !empty(collection)
    call insert(patterns, '\m\C[' . collection . ']')
  endif
  return patterns
endfunction

" Normalize the homoglyphs in the given lines. Accepts either two line
" specifications (from a command or Visual mode), or the single type
" argument passed by 'operatorfunc' (then the lines of the last change).
function! homoglyphs#normalize(...) abort
  let [first, last] = a:0 == 2 ? [a:1, a:2] : ["'[", "']"]
  let first = type(first) == type(0) ? first : line(first)
  let last  = type(last)  == type(0) ? last  : line(last)

  " Map each homoglyph to its replacement; the first normalization listing a
  " character wins, as when they are applied one after the other.
  let s:replacements = {}
  for [ascii, glyphs] in g:normalizations
    for nr in str2list(glyphs)
      let glyph = nr2char(nr)
      if !has_key(s:replacements, glyph)
        let s:replacements[glyph] = ascii
      endif
    endfor
  endfor
  let patterns = homoglyphs#patterns(join(keys(s:replacements), ''))

  for lnum in range(first, last)
    let old = getline(lnum)
    " skip ASCII-only lines without vertical tab or form feed
    if strlen(old) == strchars(old) && old !~# '[\x0b\x0c]'
      continue
    endif
    let new = old
    for pattern in patterns
      let new = substitute(new, pattern, '\=s:replacements[submatch(0)]', 'g')
    endfor
    if new !=# old
      call setline(lnum, new)
    endif
  endfor
endfunction

" Normalize v:count1 lines from the cursor on, but at most up to the last one.
function! homoglyphs#normalize_lines() abort
  let first = line('.')
  call homoglyphs#normalize(first, min([line('$'), first + v:count1 - 1]))
endfunction

function! homoglyphs#define_highlights() abort
  highlight homoglyphfg cterm=underline ctermfg=DarkGreen ctermbg=NONE gui=undercurl guifg=DarkGreen guibg=NONE
  highlight homoglyphbg ctermfg=NONE ctermbg=DarkGreen guifg=NONE guibg=DarkGreen
endfunction

function! homoglyphs#define_syntax() abort
  syntax case match

  silent! syntax clear homoglyphbg
  silent! syntax clear homoglyphfg

  for pattern in homoglyphs#patterns(g:ws_and_invis_homoglyphs)
    execute 'syntax match homoglyphbg' string(pattern) 'containedin=ALL'
  endfor
  for pattern in homoglyphs#patterns(g:homoglyphs)
    execute 'syntax match homoglyphfg' string(pattern) 'containedin=ALL'
  endfor
endfunction

function! homoglyphs#enable() abort
  augroup HighlightHomoglyphs
    autocmd!
    autocmd ColorScheme * call homoglyphs#define_highlights()
    autocmd Syntax * call homoglyphs#define_syntax()
  augroup END

  call homoglyphs#define_highlights()
  call homoglyphs#define_syntax()
endfunction

function! homoglyphs#toggle() abort
  if g:is_homoglyph_on
    call homoglyphs#off()
    echomsg 'Setting homoglyph highlight off'
  else
    call homoglyphs#on()
    echomsg 'Setting homoglyph highlight on'
  endif
endfunction

function! homoglyphs#off() abort
  if !g:is_homoglyph_on
    return
  endif

  augroup HighlightHomoglyphs
    autocmd!
  augroup END
  highlight clear homoglyphbg
  highlight clear homoglyphfg

  let g:is_homoglyph_on = 0
endfunction

function! homoglyphs#on() abort
  if g:is_homoglyph_on
    return
  endif

  call homoglyphs#enable()

  let g:is_homoglyph_on = 1
endfunction
