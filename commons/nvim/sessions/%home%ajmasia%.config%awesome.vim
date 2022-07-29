let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/awesome
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +16 NvimTree
badd +485 themes/powerarrow/theme.lua
badd +53 lain/util/separators.lua
badd +561 rc.lua
badd +145 themes/multicolor/theme.lua
badd +1 lain/lain-scm-1.rockspec
badd +1 lain/init.lua
badd +174 lain/helpers.lua
badd +1 lain/wiki/_Footer.md
badd +1 lain/wiki/_Sidebar.md
badd +1 lain/widget/alsa.lua
badd +1 lain/util/markup.lua
badd +1 lain/util/init.lua
argglobal
%argdel
edit themes/powerarrow/theme.lua
argglobal
balt themes/multicolor/theme.lua
let s:l = 490 - ((32 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 490
normal! 012|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
