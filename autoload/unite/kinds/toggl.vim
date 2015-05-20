" FILE: unite/kinds/task.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:kind_task = {
      \ 'name' : 'toggl/task',
      \ 'action_table' : {},
      \ 'default_action' : 'restart',
      \}

let s:kind_task.action_table.restart = {
      \ 'description': "restart selected task"
      \ }

function! s:kind_task.action_table.restart.func(candidate) abort
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


let s:kind_project = {
      \ 'name': 'toggl/project',
      \ 'action_table': {},
      \ 'default_action': 'set_current',
      \ }

let s:kind_project.action_table.set_current = {
      \ 'description': 'set the project of the current task'
      \ }

function! s:kind_project.action_table.set_current.func(candidate) abort
  let project = a:candidate.source__project
  echo project
endfunction

function! unite#kinds#toggl#define() abort
  return [s:kind_task, s:kind_project]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

