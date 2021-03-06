Every once in a while one pastes some (markup) code or prose from the internet into Vim and is at loss why it does not compile or render as meant to.
This plug-in offers a hint and a solution by providing

- highlighting of [Unicode Homoglyphs](https://www.irongeek.com/homoglyph-attack-generator.php), characters (among them many white spaces) that only appear like ASCII characters but are not, and
- the normal mode mapping `cu` to toggle it,

and

- an operator mapping `gy` in normal mode, for example `gyip` operates on a paragraph,
- a mapping `gyy` (and `gygy`) in normal mode that operates on a single line,
- a mapping `gy` that operates on the visual selection, and
- a command `NormalizeHomoglyphs` that operates on given range (equal to the whole buffer if unspecified)

that normalize [Unicode Homoglyphs](https://www.irongeek.com/homoglyph-attack-generator.php).

# Usage

For example, hitting `gyip` on

```
!ǃ！
"״″＂
```

turns it into

```
!!!
""""
```

# Configuration

To disable highlighting of [Unicode homoglyphs](https://www.irongeek.com/homoglyph-attack-generator.php) by default, add to your `vimrc` the line

```vim
    let g:is_homoglyph_on = 0
```

To change mappings, for example, to use `zy` instead of `gy` and `zu` instead of `cu`, add the lines

```vim
    nmap zy <plug>(NormalizeHomoglyphs)
    xmap zy <plug>(NormalizeHomoglyphs)

    nmap zu <plug>(HighlightHomoglyphs)
```

to your `vimrc`.

# Related

The [vim-troll-stopper](https://github.com/vim-utils/vim-troll-stopper) plug-in highlights and replaces Unicode homoglyphs commonly used to play pranks on coders.
It is similar to this plug-in, but apparently its description made it hard to be found for me;
I stumbled upon it way down the road by coincidence.

For more convenient version control of prose, see the Vim plug-in [vim-sentence-chopper](https://github.com/Konfekt/vim-sentence-chopper) that puts each sentence onto a single line.

