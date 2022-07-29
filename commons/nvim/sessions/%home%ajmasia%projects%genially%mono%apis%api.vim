let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/genially/mono/apis/api
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +168 ~/projects/genially/mono/apps/panel/src/app/stores/geniallyStore.ts
badd +64 ~/projects/genially/mono/apps/panel/src/app/stores/models/genially.ts
badd +252 ~/projects/genially/mono/apps/panel/src/app/services/geniallyService.ts
badd +79 ~/projects/genially/mono/apps/panel/src/app/App.jsx
badd +151 ~/projects/genially/mono/apps/panel/src/app/use-cases/initialLoad.ts
badd +61 ~/projects/genially/mono/apps/panel/src/app/services/authService.ts
badd +68 ~/projects/genially/mono/apps/panel/src/app/pages/dashboard/TeamDashboard.tsx
badd +71 ~/projects/genially/mono/ui/build/hooks/useLivePagination.d.ts
badd +30 src/core/genially/domain/GeniallyName.ts
badd +229 src/core/genially/domain/Genially.ts
badd +153 ~/projects/genially/mono/apps/panel/src/app/components/modal/upgrade-plan/UpgradePlanConfirmModal.jsx
badd +1348 ~/projects/genially/mono/ui/node_modules/@types/react/index.d.ts
badd +76 ~/projects/genially/mono/apps/panel/src/app/components/modal/upgrade-plan/UpgradePlanConfirmModal.styled.ts
argglobal
%argdel
edit ~/projects/genially/mono/apps/panel/src/app/components/modal/upgrade-plan/UpgradePlanConfirmModal.jsx
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
balt ~/projects/genially/mono/apps/panel/src/app/components/modal/upgrade-plan/UpgradePlanConfirmModal.styled.ts
let s:l = 139 - ((49 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 139
normal! 029|
lcd ~/projects/genially/mono/apps/panel
wincmd w
argglobal
if bufexists(fnamemodify("~/projects/genially/mono/apis/api/src/core/genially/domain/GeniallyName.ts", ":p")) | buffer ~/projects/genially/mono/apis/api/src/core/genially/domain/GeniallyName.ts | else | edit ~/projects/genially/mono/apis/api/src/core/genially/domain/GeniallyName.ts | endif
if &buftype ==# 'terminal'
  silent file ~/projects/genially/mono/apis/api/src/core/genially/domain/GeniallyName.ts
endif
balt ~/projects/genially/mono/apps/panel/src/app/services/authService.ts
let s:l = 28 - ((27 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 28
normal! 05|
lcd ~/projects/genially/mono/apis/api
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
