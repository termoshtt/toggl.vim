" FILE: unite/sources/toggl.vim
" AUTHOR:  Toshiki TERAMUREA <toshiki.teramura@gmail.com>
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:source = {
      \ 'name': 'toggl'
      \ }

function! s:source.gather_candidates(args,context) abort
  return map(reverse(toggl#list()), '{
        \ "word": v:val["description"],
        \ "source": "toggl",
        \ "kind": "task",
        \ "source__task": v:val,
        \ }')
endfunction

function! unite#sources#toggl#define() 
  return s:source
endfunction 

let &cpo = s:save_cpo
unlet s:save_cpo

