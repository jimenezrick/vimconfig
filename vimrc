" IMPORTANT: Uncomment if necessary, Vim must start with filetype disabled.
"filetype off

call pathogen#infect()
call pathogen#helptags()

set guioptions+=c
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R

let s:uname = split(system("uname"))[0]
if s:uname == "Darwin"
	set guifont=Monaco:h10
elseif $TERM =~ "xterm"
	set t_Co=256
	colorscheme zenburn
elseif $TERM =~ "rxvt-unicode"
	colorscheme miromiro
endif

filetype plugin indent on
syntax on

autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax foldnestmax=2 cinoptions=h0
autocmd FileType erlang setlocal foldmethod=expr
autocmd FileType python setlocal foldmethod=indent
autocmd FileType haskell,ocaml setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType tex,mail setlocal textwidth=72 spell
autocmd BufNewFile,BufRead README,*.txt,*.markdown,*.md setlocal textwidth=72 spell

let g:erlangManPath="/usr/local/lib/erlang/man"
let g:erlangHighlightBIFs=1

" Use Omni completion with `CTRL-X + CTRL-O'.
" Create the system tags file with this command:
"	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/systags /usr/include /usr/local/include
set tags+=~/.vim/systags
set tags+=~/.vim/bundle/tags-cpp-stl/tags-cpp-stl
set nocompatible
set nobackup
set backspace=indent,eol,start
set showmode
set number
set ruler
set showmatch
set hlsearch
set autoindent
set incsearch
set nowrap
set list
set listchars=tab:\|\ ,trail:·,precedes:<,extends:>
set nofoldenable
set foldnestmax=1
set spelllang=es,en
set nospell

match Todo /TODO\|FIXME\|XXX\|FUCKME/

map <F1> :NERDTree<Enter>
map <F2> :write<Enter>
map <F3> :nohlsearch<Enter>
map <F4> :make<Enter>
map <F5> :shell<Enter>
map <F6> :TlistToggle<Enter>
map <F9> :checktime<Enter>
map <F10> :DiffChangesDiffToggle<Enter>
map <F11> :w!<Enter>:!aspell check %<Enter>:w %<Enter>
map <F12> :SpellThis<Enter>
