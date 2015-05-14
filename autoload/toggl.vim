let s:save_cpo = &cpo
set cpo&vim

function! toggl#start(taskname) abort
  echoerr "Not implemented"
endfunction

function! toggl#stop() abort
  let now = toggl#api#get_running_entry()
  call toggl#api#stop_entry(now.id)
endfunction

function! toggl#list() abort
  echoerr "Not implemented"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
