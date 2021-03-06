" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

if exists("g:nnnvi_ftplugin")
  finish
endif
let b:nnnvi_ftplugin = 1

if exists('g:nnnvi') && has_key(g:nnnvi, 'maps')
  for key in keys(g:nnnvi.maps)
    exec 'tnoremap <nowait><buffer><silent> '.key.' <c-\><c-n>:<c-u>call nnnvi#set_action("'.g:nnnvi.maps[key].'")<cr>'
  endfor
endif

setlocal nospell bufhidden=wipe nobuflisted
