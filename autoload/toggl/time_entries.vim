" FILE: toggl/time_entries.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT
"
" A KISS wrapper of Toggl API (v8), Time Entries
" https://github.com/toggl/toggl_api_docs/blob/master/chapters/time_entries.md

let s:save_cpo = &cpo
set cpo&vim

function! s:wrapper(callback) abort
  let closure = {'_callback': a:callback}
  function! closure.callback(contents) dict
    return self._callback(a:contents.data)
  endfunction
  return closure
endfunction

function! toggl#time_entries#start(description, pid, tags, ...) abort
  let rest = 'time_entries/start'
  let opt = {'time_entry': {
        \ 'description': a:description,
        \ 'pid': a:pid,
        \ 'tags': a:tags,
        \ 'created_with': "toggl.vim",
        \ }}
  if len(a:000) > 0 && type(a:1) == 2
    " async
    let c = s:wrapper(a:1)
    call toggl#async#post(res, opt, c.callback)
  else
    " sync
    return toggl#sync#post(rest, opt).data
  endif
endfunction

function! toggl#time_entries#get_running() abort
  return toggl#sync#get("time_entries/current", {}).data
endfunction

function! toggl#time_entries#stop(time_entry_id) abort
  return toggl#sync#put("time_entries/" . a:time_entry_id . "/stop", {})
endfunction

function! toggl#time_entries#range(start, end) abort
  return toggl#sync#get("time_entries", {
        \ 'start_date': a:start,
        \ 'end_date'  : a:end
        \ })
endfunction

function! toggl#time_entries#update(time_entry_id, update_data) abort
  let data = {'time_entry': a:update_data}
  return toggl#sync#put("time_entries/" . a:time_entry_id, data)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
