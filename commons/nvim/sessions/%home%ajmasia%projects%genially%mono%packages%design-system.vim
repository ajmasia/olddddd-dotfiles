let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/genially/mono/packages/design-system
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +1 src/style/themes/index.ts
badd +1 src/style/themes/primary/size.ts
badd +0 src/style/themes/primary/border.ts
badd +1 src/style/index.ts
badd +37 src/style/themes/primary/primary.ts
argglobal
%argdel
edit src/style/themes/primary/primary.ts
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt src/style/themes/primary/size.ts
let s:l = 39 - ((38 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 39
normal! 023|
lcd ~/projects/genially/mono/packages/design-system
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/packages/design-system/src/style/themes/primary/border.ts", ":p")) | buffer ~/projects/genially/mono/packages/design-system/src/style/themes/primary/border.ts | else | edit ~/projects/genially/mono/packages/design-system/src/style/themes/primary/border.ts | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/packages/design-system/src/style/themes/primary/border.ts
endif
balt ~/projects/genially/mono/packages/design-system/src/style/themes/primary/size.ts
let s:l = 1 - ((0 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/projects/genially/mono/packages/design-system
wincmd w
wincmd =
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
