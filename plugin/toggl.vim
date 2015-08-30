" FILE: toggl.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:toggl#cache_directory')
  let g:toggl#cache_directory = expand("~/.cache/toggl.vim")
endif

if !isdirectory(g:toggl#cache_directory)
  call mkdir(g:toggl#cache_directory)
  echo "Cache directory " . g:toggl#cache_directory . " is created."
endif

command! -nargs=1 TogglStart call toggl#start(<q-args>)
command! -nargs=0 TogglStop call toggl#stop()

let &cpo = s:save_cpo
unlet s:save_cpo
