" ~/.vimrc

" Specify a directory for plugins -- but this doesn't manage nvim-R?
"call plug#begin('~/.vim/plugged')

			
set statusline=%f%m%r%h%w\ [BUF=%n]\ [FF=%{&ff}]\ [TYPE=%Y]%=[HEX=\%02.2B]\ [COL=%c%V]\ [%l/%L][%p%%][%o]
set laststatus=2

set guifont=Source\ Code\ Pro\ Medium:h15

set nu
set expandtab
set noai
set wrap
set tabstop=4
set sw=4
set nosol
"set sta

"set backspace = block && insert && all
set bs=2

set cpoptions=ce$

set matchpairs=(:),[:],{:},<:>

set noerrorbells
set visualbell

set hlsearch
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set foldmethod=indent
set fdo-=search " search only in open folds

set nospell

set ruler 

set guicursor+=a:blinkon0 " no blinking cursor in any mode

set backspace=indent,eol,start  " make that backspace key work the way it should

" No Ex mode
nnoremap Q <nop>  

autocmd BufEnter * :cd %:p:h " current directory is the directory the file we're editing is in

au BufNewFile,BufRead *.fasta,*.fa  setf fasta

au BufEnter *.c,*.cc,*.h,*.pl,*.pm,*.py,*.sh,*.java,*.tex set ai
au BufLeave *.c,*.cc,*.h,*.pl,*.pm,*.py,*.sh,*.java,*.tex set noai

au BufEnter *.c,*.cc,*.h,*.pl,*.pm,*.py,*.sh,*.java set nospell
au BufLeave *.c,*.cc,*.h,*.pl,*.pm,*.py,*.sh,*.java set spell

au BufEnter mutt* set textwidth=60
au BufLeave mutt* set textwidth=0

au BufEnter Makefile,*.tsv set noexpandtab
au BufLeave Makefile,*.tsv set expandtab

au BufEnter *.rb set tabstop=2
au BufLeave *.rb set tabstop=4

"   ,rl = run latex (on current file)
    map ,rl :!pdflatex %
    map ,rb :!bibtex %
"   ,rd = run xdvi on dvi of current file
    map ,rd :!xdvi %<.dvi
    map ,rp :!open %<.pdf



if has('gui_running')
"    set fu
    set background=dark
    colorscheme solarized
    set gfn=Source\ Code\ Pro\ Medium:h15
    set linespace=1
endif

" from Damian Conway's instantly better vim

"====[ Make the 81st column stand out ]====================
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight the match in red ]=============
"function! HLNext (blinktime)
"let [bufnum, lnum, col, off] = getpos('.')
"let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/)) let target_pat = '\c\%#'.@/
"let ring = matchadd('WhiteOnRed', target_pat, 101)
"redraw
"exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"call matchdelete(ring)
"redraw
"endfunction

" show tabs and trailing whitespace
"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~" set list

nnoremap ; :
nnoremap v <C-V>


" vim to R communication

set nocompatible
syntax enable
filetype plugin on
filetype indent on

let R_in_buffer = 0
let R_notmuxconf = 1
let R_term_cmd = "iterm -title R -e"

let R_assign = 0 " get rid of _ auto-completing to <-
let Rout_more_colors = 1

" start R if not running and opening an R file
" TODO: these start R every time, not only if it's not already running
"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
"autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif


" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Oct-14 15:33):
" Change the <LocalLeader> key:
let maplocalleader = ","   ",rf to start R; ,rq to quit
" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Force Vim to use 256 colors if running in a capable terminal emulator:
if &term =~ "xterm" || &term =~ "256" || $DISPLAY != "" || $HAS_256_COLORS == "yes"
    set t_Co=256
endif

" file is large from 1gb
let g:LargeFile = 1024 * 1024 * 1024
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction


syntax on

augroup vimrc
   autocmd!
   autocmd ColorScheme * highlight Search guibg=peru guifg=#FFFFFF | highlight Folded guibg=#444444 guifg=#000000 | highlight Folded ctermbg=darkgrey ctermfg=black | highlight Todo guibg=#444444 guifg=#000000
augroup END

" colour modifications to default highlighting in macvim colorscheme
"hi Search guibg=peru guifg=#FFFFFF
"hi Folded guibg=#444444 guifg=#000000
"hi Folded ctermbg=darkgrey ctermfg=black
"hi MatchParen ctermbg=black ctermfg=green

