" FILE: unite/kinds/task.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:kind = {
      \ 'name' : 'task',
      \ 'action_table' : {},
      \ 'default_action' : 'restart',
      \}

let s:kind.action_table.restart = {
      \ 'description': "restart selected task"
      \ }
function! s:kind.action_table.restart.func(candidate) abort
  let task = a:candidate.source__task
  if has_key(task, "pid")
    let pid = task.pid
  else
    let pid = 0
  endif
  if has_key(task, "tags")
    let tags = task.tags
  else
    let tags = []
  endif
  let res = toggl#time_entries#start(task.description, pid, tags)
  echo 'Start task: ' . res.description
endfunction

function! unite#kinds#task#define() abort
  return s:kind
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

