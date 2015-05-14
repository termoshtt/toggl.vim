let s:save_cpo = &cpo
set cpo&vim

function! toggl#start(taskname) abort
  echoerr "Not implemented"
endfunction

function! toggl#stop() abort
  echoerr "Not implemented"
endfunction

function! toggl#list() abort
  echoerr "Not implemented"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
