" FILE: toggl/util.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
"
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:json = s:V.import("Web.JSON")

function! toggl#util#parse_response(response) abort
  if a:response.success == 0
    throw "Toggl.vim: Request failed: " . a:response.statusText
  endif
  return s:json.decode(a:response.content)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
