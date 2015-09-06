" FILE: toggl/cache.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT
"
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:json = s:V.import("Web.JSON")

let s:task_json = g:toggl#cache_directory . "/task.json"
let s:project_json = g:toggl#cache_directory . "/project.json"

if !exists('g:toggl#cache_directory')
  let g:toggl#cache_directory = expand("~/.cache/toggl.vim")
endif

if !isdirectory(g:toggl#cache_directory)
  call mkdir(g:toggl#cache_directory)
endif

function! s:save(obj, filename) abort
  let encoded = s:json.encode(a:obj)
  call writefile([encoded, ], a:filename)
endfunction

function! s:load(filename) abort
  let encoded = readfile(a:filename)[0]
  return s:json.decode(encoded)
endfunction

function! toggl#cache#save_task(task_list) abort
  call s:save(a:task_list, s:task_json)
endfunction

function! toggl#cache#load_task() abort
  return s:load(s:task_json)
endfunction

function! toggl#cache#save_project(project_list) abort
  call s:save(a:project_list, s:project_json)
endfunction

function! toggl#cache#load_project() abort
  return s:load(s:project_json)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
