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
badd +181 src/components/DownloadModal/index.tsx
badd +102 NvimTree
badd +207 src/legacy/components/v1/agnostics/complexes/ModalDownload/ModalDownload.jsx
badd +37 src/legacy/components/v1/agnostics/complexes/ModalDownload/components/HTML5Download.jsx
badd +11 src/components/DownloadModal/components/buttons/DownloadHTMLButton/DownloadHTMLButton.styled.tsx
badd +1 src/components/DownloadModal/components/buttons/DownloadPDFButton/DownloadPDFButton.styled.tsx
badd +8 src/components/DownloadModal/components/buttons/DownloadVideoButton/index.tsx
badd +34 src/components/DownloadModal/components/buttons/DownloadVideoButton/DownloadVideoButton.styled.tsx
badd +10 src/components/DownloadModal/components/buttons/DownloadPDFButton/index.tsx
badd +10 src/components/DownloadModal/components/buttons/DownloadImageButton/index.tsx
badd +36 src/components/DownloadModal/components/buttons/DownloadHTMLButton/index.tsx
badd +51 src/components/DownloadModal/components/commonsStyles/DownloadButtons.styled.tsx
badd +10 src/components/DownloadModal/components/buttons/DownloadImageButton/DownloadImageButton.styled.tsx
badd +156 src/components/DownloadModal/components/modalContents/DownloadHtmlModalContent/index.jsx
badd +126 src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/ModalDownloadHtml.jsx
badd +1 ~/projects/genially/mono/.git/index
badd +45 src/index.ts
badd +32 src/components/DownloadModal/utils/saveFile.js
badd +327 src/config/config.ts
badd +24 src/types/globals.d.ts
badd +4 src/declare.d.ts
badd +74 src/config/appEnv.ts
badd +21 src/services/externalLogger.ts
badd +1 src/components/DownloadModal/components/modalContents/DownloadHtmlModalContent/ModalDownloadHtml.styled.jsx
badd +69 src/components/DownloadModal/utils/utils.js
badd +0 src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/index.js
argglobal
%argdel
edit src/components/DownloadModal/components/modalContents/DownloadHtmlModalContent/index.jsx
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
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
balt src/components/DownloadModal/index.tsx
let s:l = 213 - ((24 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 213
normal! 046|
lcd ~/projects/genially/mono/ui
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/ui/src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/index.js", ":p")) | buffer ~/projects/genially/mono/ui/src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/index.js | else | edit ~/projects/genially/mono/ui/src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/index.js | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/ui/src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/index.js
endif
balt ~/projects/genially/mono/ui/src/legacy/components/v1/agnostics/complexes/ModalDownloadHtml/ModalDownloadHtml.jsx
let s:l = 1 - ((0 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/projects/genially/mono/ui
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/.git/index", ":p")) | buffer ~/projects/genially/mono/.git/index | else | edit ~/projects/genially/mono/.git/index | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/.git/index
endif
balt ~/projects/genially/mono/ui/src/components/DownloadModal/index.tsx
let s:l = 6 - ((5 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 0
lcd ~/projects/genially/mono/.git
wincmd w
3wincmd w
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
