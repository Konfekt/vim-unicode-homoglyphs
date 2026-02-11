" plugin/homoglyphs.vim
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

if exists('g:loaded_unicode_homoglyphs') || &compatible
  finish
endif
let g:loaded_unicode_homoglyphs = 1

" From https://fastapi.metacpan.org/source/BIGPRESH/Unicode-Homoglyph-Replace-0.01/lib/Unicode/Homoglyph/Replace.pm
" Consider Unicode TR39 confusables for broader coverage:
" https://www.unicode.org/reports/tr39/

let s:LS   = nr2char(0x2028)
let s:PS   = nr2char(0x2029)
let s:SHY  = nr2char(0x00ad)
let s:ZWS  = nr2char(0x200b)
let s:ZWNJ = nr2char(0x200c)
let s:ZWJ  = nr2char(0x200d)
let s:WJ   = nr2char(0x2060)
let s:IS   = nr2char(0x2063)
let s:IP   = nr2char(0x2064)
let s:BOM  = nr2char(0xfeff)

let g:whitespace_homoglyphs =
      \ "\x0b\x0c"
      \ . "  ᠎"
      \ . " - "
      \ . s:LS
      \ . s:PS
      \ . "  　ㅤ"

let g:invisible_homoglyphs =
      \ s:SHY
      \ . s:ZWS
      \ . s:ZWNJ
      \ . s:ZWJ
      \ . s:WJ
      \ . s:IS
      \ . s:IP
      \ . s:BOM

let g:ws_and_invis_homoglyphs = g:whitespace_homoglyphs . g:invisible_homoglyphs

let g:normalizations = []

call extend(g:normalizations, [
      \ ['',  g:invisible_homoglyphs],
      \ [' ', g:whitespace_homoglyphs],
      \ ])

call extend(g:normalizations, [
      \ ['!=',  '≠'],
      \ ['::',  '∷'],
      \ [':=',  '≔'],
      \ ['=:',  '≕'],
      \ ['<<',  '«≪《'],
      \ ['>>',  '»≫》'],
      \ ['||',  '‖∥'],
      \ ['>=',  '≥≧⩾'],
      \ ['<=',  '≤≦⩽⇐⤆'],
      \ ['=>',  '⇒⤇'],
      \ ['<=>', '⇔⤈'],
      \ ['->',  '→➡⟶'],
      \ ['<-',  '←⬅⟵'],
      \ ['<->', '↔⟷'],
      \ ['...', '…⋯᠁'],
      \ ])

call extend(g:normalizations, [
      \ ['/',  '᜵⁄∕⧸／'],
      \ ['\\', '∖⧵⧹﹨＼'],
      \ ['~',  '˜⁓∼～'],
      \ ['&',  '﹠＆'],
      \ ['!',  'ǃⵑ︕﹗！'],
\ ['"',  '″״＂“„'],
      \ ['#',  '﹟＃'],
      \ ['$',  '﹩＄'],
      \ ['%',  '٪⁒﹪％'],
      \ ['"',  '”″״＂“„'],
      \ ["'",  '´ʹˊʹ‘’′＇︲'],
      \ ['(',  '﹙（❨⟮⦅'],
      \ [')',  '﹚）❩⟯⦆'],
      \ ['[',  '［【⟦'],
      \ [']',  '］】⟧'],
      \ ['{',  '﹛｛❴'],
      \ ['}',  '﹜｝❵'],
      \ ['*',  '⁎∗⋆﹡＊'],
      \ ['+',  '᛭﹢＋➕'],
      \ [',',  'ˏᛧ‚，'],
      \ ['.',  '·․∙⋅・．'],
      \ ['-',   '˗֊᠆‐‑־⸗⸚⎼─╴－−〰'],
      \ [' -- ',  '–‒'],
      \ [' --- ', '—―⸺⸻'],
      \ [':',  'ː˸፡᛬⁚∶⠆꞉︓﹕：'],
      \ [';',  ';؛︔﹔；'],
      \ ['<',  '˂‹≺〈❮⟨ⵦ﹤＜〈'],
      \ ['=',  '═⚌゠﹦＝᐀゠'],
      \ ['>',  '˃›≻〉❯⟩﹥＞〉'],
      \ ['?',  '︖﹖？'],
      \ ['@',  '﹫＠'],
      \ ['^',  '˄ˆᶺ⌃＾'],
      \ ['_',  'ˍ⚊﹍﹎＿﹘﹣'],
      \ ['`',  'ˋ`‵｀'],
      \ ['|',  '¦ǀᛁ∣⎜⎟⎢⎥⎪⎮│｜￨︱'],
      \ ])

call extend(g:normalizations, [
      \ ['0', '〇'],
      \ ['2', 'ᒿ'],
      \ ['3', 'Ʒℨ'],
      \ ['4', 'Ꮞ'],
      \ ['6', 'Ꮾ'],
      \ ['9', 'Ꮽ'],
      \ ])

call extend(g:normalizations, [
      \ ['A', 'ΑАᎪ'],
      \ ['B', 'ΒВᏴᗷⲂ'],
      \ ['C', 'ϹСᏟⅭⲤ'],
      \ ['D', 'ᎠᗪⅮ'],
      \ ['E', 'ΕЕᎬ'],
      \ ['F', 'ᖴ'],
      \ ['G', 'ԌᏀ'],
      \ ['H', 'ΗНዘᎻᕼⲎ'],
      \ ['I', 'ΙІⅠ'],
      \ ['J', 'ЈᎫᒍ'],
      \ ['K', 'ΚᏦᛕKⲔ'],
      \ ['L', 'ᏞᒪⅬ'],
      \ ['M', 'ΜϺМᎷⅯ'],
      \ ['N', 'ΝⲚ'],
      \ ['O', 'ΟОⲞ'],
      \ ['P', 'ΡРᏢⲢ'],
      \ ['Q', 'Ԛⵕ'],
      \ ['R', 'ᎡᏒᖇ'],
      \ ['S', 'ЅᏚ'],
      \ ['T', 'ΤТᎢ'],
      \ ['V', 'ᏙⅤ'],
      \ ['W', 'ᎳᏔ'],
      \ ['X', 'ΧХⅩⲬ'],
      \ ['Y', 'ΥⲨ'],
      \ ['Z', 'ΖᏃ'],
      \ ['Ä', 'Ӓ'],
      \ ['Ö', 'Ӧ'],
      \ ['Ü', 'Ӱ'],
      \ ])

call extend(g:normalizations, [
      \ ['a', 'ɑа'],
      \ ['b', 'Ь'],
      \ ['c', 'ϲсⅽ'],
      \ ['d', 'ԁⅾ'],
      \ ['e', 'еᥱ'],
      \ ['f', 'ƒ'],
      \ ['g', 'ɡ'],
      \ ['h', 'һ'],
      \ ['i', 'іⅰ'],
      \ ['j', 'ϳј'],
      \ ['k', 'κк'],
      \ ['l', 'ⅼ'],
      \ ['m', 'ⅿ'],
      \ ['n', 'ᥒ'],
      \ ['o', 'οоഠⲟ'],
      \ ['p', 'рⲣ'],
      \ ['q', 'ԛ'],
      \ ['s', 'ѕ'],
      \ ['t', 'τт'],
      \ ['u', 'ᥙ∪'],
      \ ['v', 'νѵᴠⅴ∨⋁'],
      \ ['w', 'ᴡ'],
      \ ['x', 'хⅹⲭ×'],
      \ ['y', 'уỿ'],
      \ ['z', 'ᴢ'],
      \ ])

let s:fullwidth_norms = []
for codepoint in range(char2nr('!'), char2nr('~'))
  let ascii = nr2char(codepoint)
  let fw = nr2char(codepoint + 0xFEE0)
  call add(s:fullwidth_norms, [ascii, fw])
endfor
call extend(g:normalizations, s:fullwidth_norms)
unlet s:fullwidth_norms
unlet codepoint
unlet ascii
unlet fw

let g:homoglyphs = ''
for norm in g:normalizations
  let g:homoglyphs .= norm[1]
endfor
unlet norm

function! s:DefineHighlights() abort
  highlight homoglyphfg cterm=underline ctermfg=DarkGreen ctermbg=NONE gui=undercurl guifg=DarkGreen guibg=NONE
  highlight homoglyphbg ctermfg=NONE ctermbg=DarkGreen guifg=NONE guibg=DarkGreen
endfunction

function! s:DefineSyntax() abort
  syntax case match

  silent! syntax clear homoglyphbg
  silent! syntax clear homoglyphfg

  execute printf("syntax match homoglyphbg '[%s]' containedin=ALL", g:ws_and_invis_homoglyphs)
  execute printf("syntax match homoglyphfg '[%s]' containedin=ALL", g:homoglyphs)
endfunction

function! HomoglyphsOn() abort
  augroup HighlightHomoglyphs
    autocmd!
    autocmd ColorScheme * call s:DefineHighlights()
    autocmd Syntax * call s:DefineSyntax()
  augroup END

  silent doautocmd HighlightHomoglyphs ColorScheme
  silent doautocmd HighlightHomoglyphs Syntax
endfunction

if !exists('g:is_homoglyph_on')
  let g:is_homoglyph_on = 1
endif

if g:is_homoglyph_on
  call HomoglyphsOn()
endif

command! -range=% -bar NormalizeHomoglyphs call homoglyphs#normalize(<line1>, <line2>)

nnoremap <silent> <Plug>(NormalizeHomoglyphs) :<C-U>set operatorfunc=homoglyphs#normalize<CR>g@
xnoremap <silent> <Plug>(NormalizeHomoglyphs) :<C-U>call homoglyphs#normalize("'<", "'>")<CR>

if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'n')
  silent! nmap <unique> gy <Plug>(NormalizeHomoglyphs)
endif
if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'x')
  silent! xmap <unique> gy <Plug>(NormalizeHomoglyphs)
endif

if hasmapto('gy', 'n')
  silent! nnoremap <unique><silent> gyy :<C-U>call homoglyphs#normalize(line('.'), line('.') + v:count1 - 1)<CR>
  silent! nnoremap <unique><silent> gygy gyy
endif

silent! nnoremap <unique><silent> <Plug>(HighlightHomoglyphs) :<C-U>call homoglyphs#toggle()<CR>
if !hasmapto('<Plug>(HighlightHomoglyphs)', 'n')
  silent! nmap <unique> cu <Plug>(HighlightHomoglyphs)
endif
