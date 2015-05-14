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

function! s:call_api(rest, method) abort
  let url = g:toggl_url_base . a:rest
  let result = s:http.request({
        \ 'url' : url,
        \ 'method' : a:method,
        \ 'username' : g:toggl_api_token,
        \ 'password' : 'api_token',
        \ 'client' : ["curl"],
        \ 'authMethod' : "basic",
        \ })
  return s:json.decode(result.content)
endfunction

function! toggl#api#get_running_entry() abort
  return s:call_api("time_entries/current", "GET").data
endfunction

function! toggl#api#stop_entry(time_entry_id) abort
  return s:call_api("time_entries/" . a:time_entry_id . "/stop", "PUT")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
