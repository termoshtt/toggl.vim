" FILE: toggl/async.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>

let s:save_cpo = &cpo
set cpo&vim

function! toggl#sync#get(rest, param, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_get(a:param)
  call curl#async#request(url, setting, a:callback)
endfunction

function! toggl#sync#put(rest, data, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_put(a:data)
  call curl#request(url, setting, a:callback)
endfunction

function! toggl#sync#post(rest, data, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_post(a:data)
  call curl#request(url, setting, a:callback)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

