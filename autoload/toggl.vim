" FILE: toggl.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

function! s:parse_args(args) abort
  let result = {
        \ "words": split(a:args),
        \ "tags": [],
        \ "args": [],
        \ }
  for s in result.words 
    if s[0] == "+"
      let result.project = s[1:]
    elseif s[0] == "@"
      call add(result.tags, s[1:])
    else
      call add(result.args, s)
    endif
  endfor
  return result
endfunction

function! toggl#start(args) abort
  let args = s:parse_args(a:args)
  if has_key(args, "project")
    let pid = s:get_pid(args.project)
  else
    let pid = 0
  endif
  let res = toggl#time_entries#start(join(args.args, " "), pid, args.tags)
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

function! s:getftime_of_days_ago(days) abort
  let t = localtime() - a:days * 24 * 60 * 60
  let pre = strftime("%FT%T%z", t)
  return pre[:-3] . ':' . pre[-2:]
endfunction

function! toggl#list() abort
  let now = s:getftime_of_days_ago(0)
  let week_ago = s:getftime_of_days_ago(7)
  return toggl#time_entries#range(week_ago, now)
endfunction

function! toggl#projects() abort
  let wid = toggl#workspaces#get()[0].id
  return toggl#workspaces#projects(wid)
endfunction

function! s:get_pid(project_name) abort
  return 0
endfunction

function! toggl#tags() abort
  let wid = toggl#workspaces#get()[0].id
  return toggl#workspaces#tags(wid)
endfunction

function! toggl#update_current(data) abort
  let now = toggl#time_entries#get_running()
  if now is 0
    throw "No task is running"
    return
  endif
  return toggl#time_entries#update(now.id, a:data)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
