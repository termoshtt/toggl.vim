" FILE: toggl.vim
" AUTHOR: Toshiki Teramura <toshiki.teramura@gmail.com>
" LICENCE: MIT

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 TogglStart call toggl#start(<q-args>)
command! -nargs=0 TogglStop call toggl#stop()

let &cpo = s:save_cpo
unlet s:save_cpo
