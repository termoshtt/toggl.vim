" FILE: unite/sources/toggl.vim
" AUTHOR:  Toshiki TERAMUREA <toshiki.teramura@gmail.com>
" License: MIT

let s:source = {
      \ 'name': 'toggl'
      \ }

function! s:source.gather_candidates(args,context) abort
  return map(reverse(toggl#list()), '{
        \ "word": v:val["description"],
        \ "source": "toggl",
        \ "kind": "word",
        \ }')
endfunction

function! unite#sources#toggl#define() 
  return s:source
endfunction 
