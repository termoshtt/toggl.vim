let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("vital")
let s:json = s:V.import("Web.JSON")

function! toggl#util#parse_request(request) abort
  if a:request.success == 0
    throw "Toggl.vim: Request failed: " . a:request.statusText
  endif
  return s:json.decode(a:request.content)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
