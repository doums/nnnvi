## nnnvi

A [n](https://neovim.io/)/[vim](https://www.vim.org/) plugin that uses [nnn](https://github.com/jarun/nnn) as a file manager.

### install

If you use a plugin manager, follow the traditional way.

For example with [vim-plug](https://github.com/junegunn/vim-plug) add this in `.vimrc`/`init.vim`:
```
Plug 'doums/oterm'
Plug 'doums/nnnvi'
```

Then run in vim:
```
:source $MYVIMRC
:PlugInstall
```
If you use vim package `:h packages`.

### configuration

To avoid overriding nnn's own keybinds there is no default configuration. But you can assign custom maps to vim command that will be executed to open the file(s) you have selected.

```
" .vimrc/init.vim

let g:nnnvi = {
      \  '<A-s>': 'split',
      \  '<A-v>': 'vsplit',
      \  '<A-t>': 'tabedit',
      \}
```

#### commands

```
:NNN
```
Open nnn in non persistent session mode. (no `-S` option)

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
