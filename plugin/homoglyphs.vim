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
" 0. Faites ce que vous voulez, j'en ai RIEN À BRANLER.

if exists('g:loaded_unicode_homoglyphs') || &cp
  finish
endif
let g:loaded_unicode_homoglyphs = 1

let s:keepcpo         = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

" From https://fastapi.metacpan.org/source/BIGPRESH/Unicode-Homoglyph-Replace-0.01/lib/Unicode/Homoglyph/Replace.pm
" TODO Update to list at https://www.irongeek.com/homoglyph-attack-generator.php
let g:whitespace_homoglyphs = '\x0b\x0c\u00a0\u1680\u180e\u1160\u2000-\u200a\u202F\u205F\u3000\u3164\ufeff'
let g:normalizations = [
      \ [' ',  g:whitespace_homoglyphs],
      \ ['/', '\uFF0F\u1735\u2044\u2215\u29F8'],
      \ ['\', '\u2216\u29F5\u29F9\uFE68\uFF3C'],
      \ ['~', '\u02DC\u2053\u223C\uFF5E'],
      \ ['&', '\uFE60\uFF06'],
      \ ['!',  '\u01C3\u2D51\uFE15\uFE57\uFF01'],
      \ ['"',  '\u2033\u05f4\uFF02\u201c\u201d'],
      \ ['#',  '\uFE5F\uFF03'],
      \ ['$',  '\uFE69\uFF04'],
      \ ['%',  '\u066A\u2052\uFE6A\uFF05'],
      \ ["'",  '\u2018\u2019\u02B9\u0374\uFF07'],
      \ ['(',  '\uFE59\uFF08'],
      \ [')',  '\uFF09\uFE5A'],
      \ ['*',  '\u204e\u22C6\uFE61\uFF0A'],
      \ ['+',  '\u16ED\uFE62\uFF0B'],
      \ [',',  '\u02CF\u16E7\u201A\uFF0C'],
      \ ['-',  '\u02D7\u058A\u1806\u2013\u2014\u2212\u23BC\u2574\uFE58\uFE63\uFF0D\u2010-\u2015'],
      \ ['.',  '\u2024\uFF0E'],
      \ ['2',  '\u14BF'],
      \ ['3',  '\u01B7\u2128'],
      \ ['4',  '\u13CE'],
      \ ['6',  '\u13EE'],
      \ ['9',  '\u13ED'],
      \ [':',  '\u02D0\u02F8\u0589\u1361\u16EC\u205A\u2236\u2806\uFE13\uFE55\uFF1A'],
      \ [';',  '\u037E\uFE14\uFE54\uFF1B'],
      \ ['<',  '\u02C2\u2039\u227A\u276E\u2D66\uFE64\uFF1C'],
      \ ['=',  '\u2550\u268C\u30A0\uFE66\uFF1D'],
      \ ['>',  '\u02C3\u203A\u227B\u276F\uFE65\uFF1E'],
      \ ['?',  '\uFE16\uFE56\uFF1F'],
      \ ['@',  '\uFE6B\uFF20'],
      \ ['A',  '\u0391\u0410\u13AA'],
      \ ['B',  '\u0392\u0412\u13F4\u15F7\u2C82'],
      \ ['C',  '\u03F9\u0421\u13DF\u216D\u2CA4'],
      \ ['D',  '\u13A0\u15EA\u216E'],
      \ ['E',  '\u0395\u0415\u13AC'],
      \ ['F',  '\u15B4'],
      \ ['G',  '\u050C\u13C0'],
      \ ['H',  '\u0397\u041D\u12D8\u13BB\u157C\u2C8E'],
      \ ['I',  '\u0399\u0406\u2160'],
      \ ['J',  '\u0408\u13AB\u148D'],
      \ ['K',  '\u039A\u13E6\u16D5\u212A\u2C94'],
      \ ['L',  '\u13DE\u14AA\u216C'],
      \ ['M',  '\u039C\u03FA\u041C\u13B7\u216F'],
      \ ['N',  '\u039D\u2C9A'],
      \ ['O',  '\u039F\u041E\u2C9E'],
      \ ['P',  '\u03A1\u0420\u13E2\u2CA2'],
      \ ['Q',  '\u051A\u2D55'],
      \ ['R',  '\u13A1\u13D2\u1587'],
      \ ['S',  '\u0405\u13DA'],
      \ ['T',  '\u03A4\u0422\u13A2'],
      \ ['V',  '\u13D9\u2164'],
      \ ['W',  '\u13B3\u13D4'],
      \ ['X',  '\u03A7\u0425\u2169\u2CAC'],
      \ ['Y',  '\u03A5\u2CA8'],
      \ ['Z',  '\u0396\u13C3'],
      \ ['',   '\uFF3B'],
      \ ['',   '\uFF3D'],
      \ ['^',  '\u02C4\u02C6\u1DBA\u2303\uFF3E'],
      \ ['_',  '\u02CD\u268A\uFF3F'],
      \ ['`',  '\u02CB\u1FEF\u2035\uFF40'],
      \ ['a',  '\u0251\u0430'],
      \ ['b',  '\u042c'],
      \ ['c',  '\u03F2\u0441\u217D'],
      \ ['d',  '\u0501\u217E'],
      \ ['e',  '\u0435\u1971'],
      \ ['g',  '\u0261'],
      \ ['h',  '\u04BB'],
      \ ['i',  '\u0456\u2170'],
      \ ['j',  '\u03F3\u0458'],
      \ ['l',  '\u217C'],
      \ ['m',  '\u217F'],
      \ ['n',  '\u1952'],
      \ ['o',  '\u03BF\u043E\u0D20\u2C9F'],
      \ ['p',  '\u0440\u2CA3'],
      \ ['s',  '\u0455'],
      \ ['u',  '\u1959\u222A'],
      \ ['v',  '\u03bd\u0474\u1D20\u2174\u2228\u22C1'],
      \ ['w',  '\u1D21'],
      \ ['x',  '\u0445\u2179\u2CAD\u00d7'],
      \ ['y',  '\u0443\u1EFF'],
      \ ['z',  '\u1D22'],
      \ ['{',  '\uFE5B\uFF5B'],
      \ ['|',  '\u01C0\u16C1\u239C\u239F\u23A2\u23A5\u23AA\u23AE\uFF5C\uFFE8'],
      \ ['}',  '\uFE5C\uFF5D'],
      \ ['Ä',  '\u04d2'],
      \ ['Ö',  '\u04e6'],
      \ ]

let g:homoglyphs = ''
for n in g:normalizations
  let g:homoglyphs .= n[1]
endfor

function! HomoglyphsOn() abort
  augroup HighlightHomoglyphs
    autocmd!
    autocmd ColorScheme *
          \ highlight homoglyphfg cterm=underline ctermfg=DarkGreen ctermbg=NONE gui=undercurl guifg=DarkGreen guibg=NONE |
          \ highlight homoglyphbg ctermfg=NONE ctermbg=DarkGreen guifg=NONE guibg=DarkGreen
    " Highlight homoglyphic white spaces also by background color
    exe 'autocmd Syntax * syntax case match'
    exe 'autocmd Syntax * syntax match homoglyphbg ' . "'[" . g:whitespace_homoglyphs . "]'" . ' containedin=ALL'
    exe 'autocmd Syntax * syntax match homoglyphfg ' . "'[" . g:homoglyphs . "]'" . ' containedin=ALL'
  augroup end

  silent doautocmd HighlightHomoglyphs ColorScheme
  silent doautocmd HighlightHomoglyphs Syntax
endfunction

if !exists('g:is_homoglyph_on') | let g:is_homoglyph_on = 1 | endif

if g:is_homoglyph_on
  call HomoglyphsOn()
endif

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

silent! nnoremap <unique><silent> <plug>(HighlightHomoglyphs) :<c-u>call homoglyphs#toggle()<CR>
if !hasmapto('<Plug>(HighlightHomoglyphs)', 'n')
  " Change Unicode
  silent! nmap <unique> cu <plug>(HighlightHomoglyphs)
endif

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
