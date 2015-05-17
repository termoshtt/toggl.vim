" FILE: toggl/workspaces.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT
"
" A KISS wrapper of Toggl API (v8), Workspaces
" https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md

let s:save_cpo = &cpo
set cpo&vim

function! toggl#workspaces#get() abort
  return toggl#auth#get("workspaces", {})
endfunction

function! toggl#workspaces#projects(workspace_id) abort
  return toggl#auth#get("workspaces/" . a:workspace_id . "/projects", {})
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
