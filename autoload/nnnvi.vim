" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

let s:save_cpo = &cpo
set cpo&vim

if exists('g:nnnvi_autoload')
  finish
endif
let g:nnnvi_autoload = 1

let g:nnnvi_default = {
      \  'left': 40,
      \  'min': 50
      \}
let s:command = ['nnn']
let s:temp_file = ''
let s:nnnvi_bufnr = -1
let s:action = ''

function! nnnvi#set_action(action)
  let s:action = a:action
  if has('nvim')
    call feedkeys("i\<cr>")
  else
    call term_sendkeys(s:tbuf, "\<cr>")
  endif
endfunction

function! s:extract_files()
  if !filereadable(s:temp_file)
    return []
  endif
  let lines = readfile(s:temp_file)
  if empty(lines)
    return []
  endif
  let files = uniq(filter(lines, '!isdirectory(v:val) && filereadable(v:val)'))
  if empty(files) || strlen(files[0]) <= 0
    return []
  endif
  return files
endfunction

function! s:reset()
  let s:command = ['nnn']
  let s:temp_file = ''
  let s:nnnvi_bufnr = -1
  let s:action = ''
endfunction

function! s:exit_cb(job, exit_status) abort
  if a:exit_status != 0
    call s:print_err('nnn exit status '.a:exit_status)
    call s:reset()
    return
  endif
  let files = s:extract_files()
  if empty(files)
    call s:reset()
    return
  endif
  let l:action = empty(s:action) ? 'edit' : s:action
  execute l:action fnameescape(files[0])
  for file in files[1:]
    execute 'badd' fnameescape(file)
  endfor
  call s:reset()
endfunction

function! nnnvi#open(...) abort
  if s:nnnvi_bufnr != -1
    return
  endif
  let s:temp_file = tempname()
  let command = extend(s:command, ['-p', s:temp_file])
  if a:0 > 0
    if type(a:1) != v:t_list && type(a:1) != v:t_string
      call s:print_err('nnnvi#open, wrong type for first argument, string or list of string expected')
      return
    endif
    if type(a:1) == v:t_list
      let command = extend(s:command, a:1)
    else
      let command = add(s:command, split(a:1))
    endif
  endif
  if a:0 > 1
    let directory = expand(a:2)
    if !isdirectory(directory)
      echom a:2.' is not a valid directory'
      return
    endif
    call add(command, directory)
  endif
  let s:nnnvi_bufnr = oterm#spawn({ 'command': command, 'callback': funcref('s:exit_cb'), 'layout': g:nnnvi_default, 'name': 'nnnvi', 'filetype': 'nnnvi' })
endfunction

function! s:print_err(msg)
  echohl ErrorMsg
  echom a:msg
  echohl None
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
