## nnnvi

A [n](https://neovim.io/)/[vim](https://www.vim.org/) plugin that uses [nnn](https://github.com/jarun/nnn) as a file manager.

### prerequisites
- [nnn](https://github.com/jarun/nnn)
- [oterm](https://github.com/doums/oterm)

### install

If you use a plugin manager, follow the traditional way.

For example with [vim-plug](https://github.com/junegunn/vim-plug) add this in `.vimrc`/`init.vim`:
```
Plug 'doums/nnnvi'
```

Then run in vim:
```
:source $MYVIMRC
:PlugInstall
```
If you use vim package `:h packages`.

### configuration

```
" .vimrc/init.vim

let g:nnnvi = {
      \  'layout': { 'left': 40, 'min': 50 },
      \  'maps': {
      \    '<A-s>': 'split',
      \    '<A-v>': 'vsplit',
      \    '<A-t>': 'tabedit',
      \  },
      \  'options': '-A'
      \}
```

#### `layout`
An `oterm` layout. See [oterm](https://github.com/doums/oterm). Default is `g:oterm` if it exists or `{ 'left': 40, 'min': 50 }`.

#### `maps`
To avoid overriding nnn's own keybinds there is no default maps configuration. But you are free to assign custom maps to vim command that will be executed to open the file(s) you have selected.

NOTE: Maps will be created only for nnnvi's buffer (`:h map-<buffer>`) and terminal mode.

#### `options`
Custom nnn command line options, see `man nnn`.

### commands

```
:NNN
```
Open nnn.

```
:NNNs
```
Open nnn in persistent session mode. (`-S` option is present)

You can pass a directory path as argument from which to open nnn.

### maps
Two maps are available, one for persistent session mode, the other for non persistent mode.
```
nmap <Tab> <Plug>NNNs
nmap <S-Tab> <Plug>NNNnos
```

### vimscript API
```
call nnnvi#open(nnn_options, path)
```
All arguments are optional.

#### `nnn_options`
A string or a list of string: the nnn command line options (see `man nnn`).

#### `path`
A string: a path from which to open nnn.

### license
Mozilla Public License 2.0

