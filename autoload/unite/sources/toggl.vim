" FILE: unite/sources/toggl.vim
" AUTHOR:  Toshiki TERAMUREA <toshiki.teramura@gmail.com>
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:src_task = {
      \ 'name': 'toggl/task'
      \ }

function! s:src_task.gather_candidates(args,context) abort
  return map(reverse(toggl#list()), '{
        \ "word": v:val["description"],
        \ "source": "toggl/task",
        \ "kind": "toggl/task",
        \ "source__task": v:val,
        \ }')
endfunction


let s:src_project = {
      \ 'name': 'toggl/project'
      \ }

function! s:src_project.gather_candidates(args, context) abort
  return map(reverse(toggl#projects()), '{
        \ "word": v:val["name"],
        \ "source": "toggl/project",
        \ "kind": "toggl/project",
        \ "source__project": v:val,
        \ }')
endfunction

function! unite#sources#toggl#define() 
  return [s:src_task, s:src_project]
endfunction 

let &cpo = s:save_cpo
unlet s:save_cpo

