" FILE: toggl/auth.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:json = s:V.import("Web.JSON")

if !exists("g:toggl_api_token")
  echoerr "API token for Toggl is not set"
endif

let s:settings = {
      \ 'username' : g:toggl_api_token,
      \ 'password' : 'api_token',
      \ 'client' : ["curl"],
      \ 'authMethod' : "basic",
      \ }

function! toggl#auth#get_url(rest) abort
  let s:toggl_url_base = "https://www.toggl.com/api/v8/"
  return s:toggl_url_base . a:rest
endfunction

function! toggl#auth#setting_get(param) abort
  let setting = deepcopy(s:settings)
  call extend(setting, {
        \ 'method': 'GET,',
        \ 'param': a:param,
        \ })
  return setting
endfunction

function! toggl#auth#setting_put(data) abort
  let setting = deepcopy(s:settings)
  call extend(setting, {
        \ 'method': 'PUT',
        \ 'data': s:json.encode(a:data),
        \ 'contentType': 'application/json',
        \ })
  return setting
endfunction

function! toggl#auth#setting_post(data) abort
  let setting = deepcopy(s:settings)
  call extend(setting, {
        \ 'method': 'POST',
        \ 'data': s:json.encode(a:data),
        \ 'contentType': 'application/json',
        \ })
  return setting
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
