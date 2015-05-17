" FILE: toggl.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

function! toggl#start(taskname) abort
  let res = toggl#time_entries#start(a:taskname, 0, ["toggl.vim"])
  echo 'Start task: ' . res.description
endfunction

function! toggl#stop() abort
  let now = toggl#time_entries#get_running()
  if now is 0
    echo 'No task is running'
    return
  endif
  call toggl#time_entries#stop(now.id)
  echo 'Stop task: ' . now.description
endfunction

function! toggl#list() abort
  let now = vimproc#system('date +"%FT%T%:z"')[:-2]
  let week_ago = vimproc#system('date +"%FT%T%:z" -d "now 1 week ago"')[:-2]
  let entries = toggl#time_entries#range(week_ago, now)
  return entries
endfunction

function! toggl#projects() abort
  let wid = toggl#workspaces#get()[0].id
  return toggl#workspaces#projects(wid)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
