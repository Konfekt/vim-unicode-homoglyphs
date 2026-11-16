" Headless tests for vim-unicode-homoglyphs.
" Run with test/run.sh, or:
"   vim -N -u NONE -i NONE --not-a-term --cmd 'set encoding=utf-8' -S test/test.vim
"   nvim --headless -u NONE -i NONE -S test/test.vim
" Results are written to the file in $HOMOGLYPHS_TEST_OUT (default:
" test/result.txt); the editor exits with status 1 if any test fails.
scriptencoding utf-8

let s:root = fnamemodify(expand('<sfile>:p'), ':h:h')
let s:out = empty($HOMOGLYPHS_TEST_OUT) ? s:root . '/test/result.txt' : $HOMOGLYPHS_TEST_OUT

syntax on
let &runtimepath = s:root . ',' . &runtimepath
execute 'source' fnameescape(s:root . '/plugin/homoglyphs.vim')
set noswapfile hidden

let s:log = []
let s:failed = 0

function! s:Reset(lines) abort
  enew!
  call setline(1, a:lines)
  call cursor(1, 1)
endfunction

function! s:Check(name, got, want) abort
  if a:got ==# a:want
    call add(s:log, 'ok   ' . a:name)
  else
    let s:failed += 1
    call add(s:log, 'FAIL ' . a:name . ': got ' . string(a:got) . ', want ' . string(a:want))
  endif
endfunction

function! s:SynName(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name')
endfunction

function! s:TestNormalizeChars() abort
  call s:Reset([
        \ "a\u00a0b\u2003c\u3000d",
        \ "a\u200bb\u00adc\ufeffd",
        \ 'Ａｂｃ！ＡＢＣ',
        \ 'Ηеllо Wоrld',
        \ '«x» … → ⇒ ≠ ≥',
        \ 'a–b—c',
        \ '“quoted” ‘single’',
        \ 'plain - ASCII \ & ~ / text',
        \ 'äöü 漢字 ÄÖÜ',
        \ ])
  NormalizeHomoglyphs
  call s:Check('normalize: whitespace', getline(1), 'a b c d')
  call s:Check('normalize: invisible', getline(2), 'abcd')
  call s:Check('normalize: fullwidth', getline(3), 'Abc!ABC')
  call s:Check('normalize: greek and cyrillic letters', getline(4), 'Hello World')
  call s:Check('normalize: multi-character', getline(5), '<<x>> ... -> => != >=')
  call s:Check('normalize: dashes', getline(6), 'a -- b --- c')
  call s:Check('normalize: quotes', getline(7), '"quoted" ''single''')
  call s:Check('normalize: ASCII untouched', getline(8), 'plain - ASCII \ & ~ / text')
  call s:Check('normalize: other multibyte untouched', getline(9), 'äöü 漢字 ÄÖÜ')
endfunction

function! s:TestControlCharacters() abort
  call s:Reset(["a\x0bb\x0cc\td"])
  NormalizeHomoglyphs
  call s:Check('normalize: vertical tab and form feed', getline(1), "a b c\td")
endfunction

function! s:TestUnchangedBuffer() abort
  call s:Reset(['plain ASCII', 'äöü'])
  setlocal nomodified
  NormalizeHomoglyphs
  call s:Check('unchanged: not modified', &modified, 0)
endfunction

function! s:TestBackslash() abort
  call s:Reset(['a＼b∖c'])
  NormalizeHomoglyphs
  call s:Check('normalize: backslash homoglyphs become one backslash', getline(1), 'a\b\c')
endfunction

" Neovim treats U+200C and U+200D after a letter as composing characters.
function! s:TestComposing() abort
  call s:Reset(["a\u200db\u200cc"])
  NormalizeHomoglyphs
  call s:Check('normalize: joiners after a letter', getline(1), 'abc')
endfunction

function! s:TestRange() abort
  call s:Reset(['１', '２', '３'])
  2NormalizeHomoglyphs
  call s:Check('range: only given line', getline(1, 3), ['１', '2', '３'])
endfunction

function! s:TestOptions() abort
  set gdefault ignorecase smartcase nomagic
  try
    call s:Reset(['ＡＡ аА', 'x'])
    NormalizeHomoglyphs
    call s:Check('options: nomagic, gdefault, ignorecase', getline(1), 'AA aA')
    call s:Check('options: gdefault kept', &gdefault, 1)
    call s:Check('options: magic kept', &magic, 0)
  finally
    set nogdefault noignorecase nosmartcase magic
  endtry
endfunction

function! s:TestGdefaultRestoredOnError() abort
  set gdefault
  try
    call s:Reset(['！'])
    setlocal nomodifiable
    try
      NormalizeHomoglyphs
    catch /E21/
    endtry
    call s:Check('error: gdefault restored', &gdefault, 1)
  finally
    setlocal modifiable
    set nogdefault
  endtry
endfunction

function! s:TestCursorAndMarks() abort
  call s:Reset(['abc', 'ｘｙｚ', 'def'])
  call cursor(3, 2)
  normal! m`
  call cursor(1, 3)
  NormalizeHomoglyphs
  call s:Check('cursor: kept', [line('.'), col('.')], [1, 3])
  call s:Check('cursor: `` mark kept', getpos("''")[1:2], [3, 2])
  call s:Check('search history: untouched', histget('search', -1), '')
endfunction

function! s:TestUndo() abort
  call s:Reset(['ａ！', '‘ｂ’'])
  let before = getline(1, '$')
  let &undolevels = &undolevels
  NormalizeHomoglyphs
  normal! u
  call s:Check('undo: single step', getline(1, '$'), before)
endfunction

function! s:TestOperator() abort
  call s:Reset(['ａ', 'ｂ', '', 'ｃ'])
  execute 'normal gyip'
  call s:Check('operator: gyip', getline(1, 4), ['a', 'b', '', 'ｃ'])
  call cursor(4, 1)
  execute 'normal .'
  call s:Check('operator: dot repeat', getline(4), 'c')
endfunction

function! s:TestVisual() abort
  call s:Reset(['ａ', 'ｂ', 'ｃ'])
  execute 'normal Vjgy'
  call s:Check('visual: gy', getline(1, 3), ['a', 'b', 'ｃ'])
endfunction

function! s:TestLineMappings() abort
  call s:Reset(['ａ', 'ｂ', 'ｃ', 'ｄ'])
  call s:Check('gyy: mapped', maparg('gyy', 'n'), '<Plug>(NormalizeHomoglyphsLine)')
  execute 'normal gyy'
  call s:Check('gyy: current line', getline(1, 2), ['a', 'ｂ'])
  call cursor(2, 1)
  execute 'normal gygy'
  call s:Check('gygy: current line', getline(2, 3), ['b', 'ｃ'])
  call s:Reset(['ａ', 'ｂ', 'ｃ'])
  call cursor(2, 1)
  execute 'normal 5gyy'
  call s:Check('gyy: count past the last line', getline(1, 3), ['ａ', 'b', 'c'])
endfunction

function! s:TestHighlight() abort
  call s:Reset(["a\u00a0b！c\u200bd Ａ"])
  set filetype=text
  " a, nbsp(2-3), b, ！(5-7), c, zws(9-11), d, space, Ａ(14)
  call s:Check('syntax: no-break space', s:SynName(1, 2), 'homoglyphbg')
  call s:Check('syntax: fullwidth !', s:SynName(1, 5), 'homoglyphfg')
  call s:Check('syntax: zero width space', s:SynName(1, 9), 'homoglyphbg')
  call s:Check('syntax: fullwidth A', s:SynName(1, 14), 'homoglyphfg')
  call s:Check('syntax: ASCII letter', s:SynName(1, 1), '')
  call s:Reset(['x - y \ ] ^ z'])
  set filetype=text
  call s:Check('syntax: ASCII punctuation', filter(range(1, 13), 's:SynName(1, v:val) !=# ""'), [])
endfunction

function! s:TestToggle() abort
  call s:Check('toggle: on by default', g:is_homoglyph_on, 1)
  call homoglyphs#toggle()
  call s:Check('toggle: off', g:is_homoglyph_on, 0)
  call s:Check('toggle: highlight cleared', hlexists('homoglyphbg') && synIDattr(synIDtrans(hlID('homoglyphbg')), 'bg') ==# '', 1)
  call s:Check('toggle: autocmds removed', exists('#HighlightHomoglyphs#Syntax'), 0)
  call homoglyphs#toggle()
  call s:Check('toggle: on again', g:is_homoglyph_on, 1)
  call s:Check('toggle: autocmds back', exists('#HighlightHomoglyphs#Syntax'), 1)
  call s:Check('toggle: cu mapped', maparg('cu', 'n'), '<Plug>(HighlightHomoglyphs)')
endfunction

for s:t in ['NormalizeChars', 'ControlCharacters', 'UnchangedBuffer', 'Backslash', 'Composing', 'Range', 'Options',
      \ 'GdefaultRestoredOnError', 'CursorAndMarks', 'Undo', 'Operator',
      \ 'Visual', 'LineMappings', 'Highlight', 'Toggle']
  try
    call call('s:Test' . s:t, [])
  catch
    let s:failed += 1
    call add(s:log, 'FAIL ' . s:t . ': ' . v:exception . ' @ ' . v:throwpoint)
  endtry
endfor

call add(s:log, s:failed ? s:failed . ' failed' : 'all passed')
call writefile(s:log, s:out)
execute s:failed ? 'cquit!' : 'qall!'
