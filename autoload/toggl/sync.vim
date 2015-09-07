" FILE: toggl/sync.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>

let s:save_cpo = &cpo
set cpo&vim

function! toggl#sync#get(rest, param) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_get(a:param)
  let res = curl#request(url, setting)
  return toggl#util#parse_response(res)
endfunction

function! toggl#sync#put(rest, data) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_put(a:data)
  let res = curl#request(url, setting)
  return toggl#util#parse_response(res)
endfunction

function! toggl#sync#post(rest, data) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_post(a:data)
  let res = curl#request(url, setting)
  return toggl#util#parse_response(res)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
