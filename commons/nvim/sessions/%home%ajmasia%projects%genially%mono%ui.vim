let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/genially/mono/ui
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +1 src/components/DownloadModal/index.tsx
badd +24 src/components/DownloadModal/components/DownloadOption.tsx
argglobal
%argdel
edit src/components/DownloadModal/index.tsx
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
exe 'vert 1resize ' . ((&columns * 122 + 127) / 254)
exe 'vert 2resize ' . ((&columns * 131 + 127) / 254)
argglobal
balt src/components/DownloadModal/components/DownloadOption.tsx
let s:l = 64 - ((63 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 64
normal! 0
lcd ~/projects/genially/mono/ui
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/ui/src/components/DownloadModal/components/DownloadOption.tsx", ":p")) | buffer ~/projects/genially/mono/ui/src/components/DownloadModal/components/DownloadOption.tsx | else | edit ~/projects/genially/mono/ui/src/components/DownloadModal/components/DownloadOption.tsx | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/ui/src/components/DownloadModal/components/DownloadOption.tsx
endif
balt ~/projects/genially/mono/ui/src/components/DownloadModal/index.tsx
let s:l = 23 - ((22 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 0
lcd ~/projects/genially/mono/ui
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 122 + 127) / 254)
exe 'vert 2resize ' . ((&columns * 131 + 127) / 254)
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
