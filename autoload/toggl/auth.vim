" FILE: toggl/auth.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:http = s:V.import("Web.HTTP")
let s:json = s:V.import("Web.JSON")

let s:toggl_url_base = "https://www.toggl.com/api/v8/"
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
  let g:toggl_debug_last_result = result
  if result.success == 0
    throw "Toggl.vim: Request Failed. Response Status is " . result.statusText
  endif
  return s:json.decode(result.content)
endfunction

function! toggl#auth#get(rest, param) abort
  let url = s:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "GET"
  let l:setting.param = a:param
  return s:call_api(l:setting)
endfunction

function! toggl#auth#put(rest, data) abort
  let url = s:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "PUT"
  let l:setting.data = s:json.encode(a:data)
  let l:setting.contentType = "application/json"
  return s:call_api(l:setting)
endfunction

function! toggl#auth#post(rest, data) abort
  let url = s:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.url = url
  let l:setting.method = "POST"
  let l:setting.data = s:json.encode(a:data)
  let l:setting.contentType = "application/json"
  return s:call_api(l:setting)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
