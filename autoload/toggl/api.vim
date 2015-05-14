" FILE: toggl/api.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: GPLv3

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:http = s:V.import("Web.HTTP")
let s:json = s:V.import("Web.JSON")

let g:toggl_url_base = "https://www.toggl.com/api/v8/"
if !exists("g:toggl_api_token")
  echoerr "API token for Toggl is not set"
endif

let s:settings = {
      \ 'username' : g:toggl_api_token,
      \ 'password' : 'api_token',
      \ 'client' : ["curl"],
      \ 'authMethod' : "basic",
      \ }

function! s:call_api(setting) abort
  let result = s:http.request(a:setting)
  if result.success == 0
    throw result.statusText
  endif
  return s:json.decode(result.content)
endfunction

function! s:get(rest) abort
  let url = g:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "GET"
  return s:call_api(l:setting)
endfunction

function! s:put(rest) abort
  let url = g:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "PUT"
  return s:call_api(l:setting)
endfunction

function! s:post(rest, data) abort
  let url = g:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "POST"
  let l:setting.data = s:json.encode(a:data)
  let l:setting.contentType = "application/json"
  return s:call_api(l:setting)
endfunction

function! toggl#api#start_entry(description, pid, tags) abort
  return s:post("time_entries/start", {'time_entry': {
        \ 'description': a:description,
        \ 'pid': a:pid,
        \ 'tags': a:tags,
        \ 'created_with': "toggl.vim",
        \ }})
endfunction

function! toggl#api#get_running_entry() abort
  return s:get("time_entries/current")
endfunction

function! toggl#api#stop_entry(time_entry_id) abort
  return s:put("time_entries/" . a:time_entry_id . "/stop")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
