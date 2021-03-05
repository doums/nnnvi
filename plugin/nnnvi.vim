" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

if exists('g:nnnvi_plugin')
  finish
endif
let g:nnnvi_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

command -nargs=? -complete=dir NNN call nnnvi#open('', <f-args>)
noremap <silent><unique><script> <Plug>NNNnos <SID>NNNMap
noremap <SID>NNNMap :NNN<CR>

command -nargs=? -complete=dir NNNs call nnnvi#open('-S', <f-args>)
noremap <silent><unique><script> <Plug>NNNs <SID>NNNsMap
noremap <SID>NNNsMap :NNNs<CR>

augroup nnnvi
  autocmd!
  autocmd BufEnter * if isdirectory(expand("%")) | call nnnvi#open_dir("%") | endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
