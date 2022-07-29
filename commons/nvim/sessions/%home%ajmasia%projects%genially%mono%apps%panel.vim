let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/genially/mono/apps/panel
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +56 src/app/components/modal/teams/SelectDestinyGeniallyModal/SelectDestinyGeniallyModal.tsx
badd +259 src/app/components/modal/Modal.jsx
badd +116 src/app/components/modal/inspiration/InspirationModal.tsx
badd +336 src/app/components/modal/template/TemplateModal.jsx
badd +31 src/app/pages/reuse/components/SelectDestinyAndReuse/SelectDestinyAndReuse.tsx
badd +28 src/app/pages/reuse/Reuse.tsx
badd +174 src/app/components/modal/add-page/AddPages.tsx
badd +9 src/app/use-cases/genially/reuseGenially.ts
badd +102 src/app/pages/use-template/components/SelectDestinyAndUseTemplate/SelectDestinyAndUseTemplate.tsx
badd +1 src/app/use-cases/genially/updateGenially.js
badd +118 src/app/services/geniallyService.ts
badd +1 src/app/use-cases/genially/transferGeniallyToTeam.ts
badd +21 src/app/services/index.ts
argglobal
%argdel
edit src/app/components/modal/add-page/AddPages.tsx
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
balt src/app/use-cases/genially/updateGenially.js
let s:l = 167 - ((34 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 167
normal! 015|
lcd ~/projects/genially/mono/apps/panel
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/apps/panel/src/app/components/modal/teams/SelectDestinyGeniallyModal/SelectDestinyGeniallyModal.tsx", ":p")) | buffer ~/projects/genially/mono/apps/panel/src/app/components/modal/teams/SelectDestinyGeniallyModal/SelectDestinyGeniallyModal.tsx | else | edit ~/projects/genially/mono/apps/panel/src/app/components/modal/teams/SelectDestinyGeniallyModal/SelectDestinyGeniallyModal.tsx | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/apps/panel/src/app/components/modal/teams/SelectDestinyGeniallyModal/SelectDestinyGeniallyModal.tsx
endif
balt ~/projects/genially/mono/apps/panel/src/app/components/modal/inspiration/InspirationModal.tsx
let s:l = 46 - ((31 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 46
normal! 066|
lcd ~/projects/genially/mono/apps/panel
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
