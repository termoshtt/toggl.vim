" FILE: toggl/time_entries.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT
"
" A KISS wrapper of Toggl API (v8), Time Entries
" https://github.com/toggl/toggl_api_docs/blob/master/chapters/time_entries.md

let s:save_cpo = &cpo
set cpo&vim

function! toggl#time_entries#start(description, pid, tags) abort
  return toggl#auth#post("time_entries/start", {'time_entry': {
        \ 'description': a:description,
        \ 'pid': a:pid,
        \ 'tags': a:tags,
        \ 'created_with': "toggl.vim",
        \ }})
endfunction

function! toggl#time_entries#get_running() abort
  return toggl#auth#get("time_entries/current")
endfunction

function! toggl#time_entries#stop(time_entry_id) abort
  return toggl#auth#put("time_entries/" . a:time_entry_id . "/stop")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
