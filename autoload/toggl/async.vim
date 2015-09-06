let s:save_cpo = &cpo
set cpo&vim

let s:toggl_url_base = "https://www.toggl.com/api/v8/"
if !exists("g:toggl_api_token")
  echoerr "API token for Toggl is not set"
endif

let s:settings = {
      \ 'username' : g:toggl_api_token,
      \ 'password' : 'api_token',
      \ 'authMethod' : "basic",
      \ }

function! s:echo_started_task(request) abort
  let req = toggl#util#parse_request(a:request)
endfunction

function! toggl#async#get(rest, param) abort
  let url = s:toggl_url_base . a:rest
  let l:setting = deepcopy(s:settings)
  let l:setting.param = a:param
  call curl#async#get(url, l:setting)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
