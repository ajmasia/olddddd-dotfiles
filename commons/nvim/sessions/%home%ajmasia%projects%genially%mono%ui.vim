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
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +84 src/components/DownloadVideo/DownloadVideo.tsx
badd +152 src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx
badd +18 src/services/downloadAsVideo.ts
badd +52 src/components/DownloadVideo/components/VideoSettings/VideoSettings.styled.ts
badd +45 src/components/DownloadVideo/components/VideoSettings/GeniallyPreview.tsx
argglobal
%argdel
edit src/components/DownloadVideo/DownloadVideo.tsx
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
balt src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx
let s:l = 84 - ((8 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 84
normal! 0
lcd ~/projects/genially/mono/ui
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/ui/src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx", ":p")) | buffer ~/projects/genially/mono/ui/src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx | else | edit ~/projects/genially/mono/ui/src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/ui/src/components/DownloadVideo/components/VideoSettings/VideoSettings.tsx
endif
balt ~/projects/genially/mono/ui/src/components/DownloadVideo/DownloadVideo.tsx
let s:l = 150 - ((58 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 150
normal! 06|
lcd ~/projects/genially/mono/ui
wincmd w
2wincmd w
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
