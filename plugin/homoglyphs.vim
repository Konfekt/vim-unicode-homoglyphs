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

let s:cpo_save = &cpoptions
set cpoptions&vim

" From https://fastapi.metacpan.org/source/BIGPRESH/Unicode-Homoglyph-Replace-0.01/lib/Unicode/Homoglyph/Replace.pm
" Consider Unicode TR39 confusables for broader coverage:
" https://www.unicode.org/reports/tr39/

" Characters are listed by code point, as most of them are invisible.
let g:whitespace_homoglyphs = join(map(
      \ [0x0b, 0x0c, 0xa0, 0x1680, 0x180e]
      \ + range(0x2000, 0x200a)
      \ + [0x2028, 0x2029, 0x202f, 0x205f, 0x3000, 0x3164],
      \ 'nr2char(v:val)'), '')

let g:invisible_homoglyphs = join(map(
      \ [0xad, 0x200b, 0x200c, 0x200d, 0x2060, 0x2063, 0x2064, 0xfeff],
      \ 'nr2char(v:val)'), '')

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
      \ ['\',   '∖⧵⧹﹨＼'],
      \ ['~',  '˜⁓∼～'],
      \ ['&',  '﹠＆'],
      \ ['!',  'ǃⵑ︕﹗！'],
      \ ['"',  '”″״＂“„'],
      \ ['#',  '﹟＃'],
      \ ['$',  '﹩＄'],
      \ ['%',  '٪⁒﹪％'],
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

" Fullwidth forms U+FF01 to U+FF5E of the ASCII characters ! to ~
call extend(g:normalizations,
      \ map(range(0xff01, 0xff5e), '[nr2char(v:val - 0xfee0), nr2char(v:val)]'))

let g:homoglyphs = join(map(copy(g:normalizations), 'v:val[1]'), '')

" Kept for compatibility; prefer homoglyphs#on().
function! HomoglyphsOn() abort
  call homoglyphs#enable()
endfunction

if !exists('g:is_homoglyph_on')
  let g:is_homoglyph_on = 1
endif

if g:is_homoglyph_on
  call homoglyphs#enable()
endif

command! -range=% -bar NormalizeHomoglyphs call homoglyphs#normalize(<line1>, <line2>)

nnoremap <silent> <Plug>(NormalizeHomoglyphs) :<C-U>set operatorfunc=homoglyphs#normalize<CR>g@
xnoremap <silent> <Plug>(NormalizeHomoglyphs) :<C-U>call homoglyphs#normalize("'<", "'>")<CR>
nnoremap <silent> <Plug>(NormalizeHomoglyphsLine) :<C-U>call homoglyphs#normalize_lines()<CR>
nnoremap <silent> <Plug>(HighlightHomoglyphs) :<C-U>call homoglyphs#toggle()<CR>

if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'n')
  silent! nmap <unique> gy <Plug>(NormalizeHomoglyphs)
endif
if !hasmapto('<Plug>(NormalizeHomoglyphs)', 'x')
  silent! xmap <unique> gy <Plug>(NormalizeHomoglyphs)
endif

if maparg('gy', 'n') ==# '<Plug>(NormalizeHomoglyphs)'
      \ && !hasmapto('<Plug>(NormalizeHomoglyphsLine)', 'n')
  silent! nmap <unique> gyy  <Plug>(NormalizeHomoglyphsLine)
  silent! nmap <unique> gygy <Plug>(NormalizeHomoglyphsLine)
endif

if !hasmapto('<Plug>(HighlightHomoglyphs)', 'n')
  silent! nmap <unique> cu <Plug>(HighlightHomoglyphs)
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
