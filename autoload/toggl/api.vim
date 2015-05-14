" FILE: toggl/api.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: GPLv3

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:http = s:V.import("Web.HTTP")

let g:toggl_url_base = "https://www.toggl.com/api/v8/"
if !exists("g:toggl_api_token")
  echoerr "API token for Toggl is not set"
endif

function! toggl#api#get(rest) abort
  let url = g:toggl_url_base . a:rest
  echo url
  let result = s:http.request({
        \ 'url' : url,
        \ 'method' : "GET",
        \ 'username' : g:toggl_api_token,
        \ 'password' : 'api_token',
        \ 'client' : ["curl"],
        \ })
  echo result
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
