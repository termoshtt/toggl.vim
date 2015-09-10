" FILE: toggl/async.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>

let s:save_cpo = &cpo
set cpo&vim

function! toggl#sync#get(rest, param, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_get(a:param)
  let c = toggl#util#wrapped_callback(a:callback)
  call curl#async#request(url, setting, c.callback)
endfunction

function! toggl#sync#put(rest, data, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_put(a:data)
  let c = toggl#util#wrapped_callback(a:callback)
  call curl#request(url, setting, c.callback)
endfunction

function! toggl#sync#post(rest, data, callback) abort
  let url = toggl#auth#get_url(a:rest)
  let setting = toggl#auth#setting_post(a:data)
  let c = toggl#util#wrapped_callback(a:callback)
  call curl#request(url, setting, c.callback)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

