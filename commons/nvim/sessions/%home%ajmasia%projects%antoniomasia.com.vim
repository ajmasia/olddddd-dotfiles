let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/antoniomasia.com
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +8 ~/projects/antoniomasia.com/theme.tsx
badd +19 ~/projects/antoniomasia.com/pages/_app.tsx
badd +23 components/layouts/MainLayout.tsx
badd +35 ~/projects/antoniomasia.com/package.json
badd +18 ~/projects/antoniomasia.com/components/layouts/NavBar/NavBarItem.tsx
badd +33 ~/projects/antoniomasia.com/components/layouts/NavBar/NavBar.tsx
badd +70 ~/projects/antoniomasia.com/pages/index.tsx
badd +71 ~/projects/antoniomasia.com/pages/blog.tsx
badd +22 ~/projects/antoniomasia.com/components/layouts/Footer/Footer.tsx
badd +17 ~/projects/antoniomasia.com/config.ts
badd +21 ~/projects/antoniomasia.com/components/Logo.tsx
argglobal
%argdel
edit ~/projects/antoniomasia.com/components/layouts/Footer/Footer.tsx
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt ~/projects/antoniomasia.com/pages/blog.tsx
let s:l = 38 - ((37 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 021|
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
