filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set guioptions+=c
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R

let s:uname = system("echo -n $(uname)")
if s:uname == "Darwin" && has("gui_running")
	set guifont=Monaco:h10
elseif s:uname == "Darwin"
	echo
elseif has("gui_running")
	set guifont=Terminus\ 8
	colorscheme soso
else
	set t_Co=256
	colorscheme zenburn
endif

syntax on
filetype plugin indent on
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax foldnestmax=2
autocmd FileType erlang setlocal foldmethod=expr
autocmd FileType python setlocal foldmethod=indent
autocmd FileType haskell setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType tex,mail setlocal textwidth=72 spell
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md,README setlocal textwidth=72 spell

" TODO: remove with future versions of Vim
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=72 formatoptions+=t spell
autocmd BufNewFile,BufRead *.hrl setlocal filetype=erlang

let g:erlangManPath="/usr/local/lib/erlang/man"
let g:erlangCompleteFile="~/.vim/bundle/vimerl/autoload/erlang_complete.erl"
let g:erlangCheckFile="~/.vim/bundle/vimerl/compiler/erlang_check.erl"

" Use Omni completion with `CTRL-X + CTRL-O'
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
set cursorline
set showmatch
set hlsearch
set autoindent
set incsearch
set nowrap
set list
set listchars=tab:\|\ ,trail:·,precedes:<,extends:>
"set tabstop=4
"set shiftwidth=4
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
map <F7> :TaskList<Enter>
map <F8> :CompView<Enter>
map <F9> :checktime<Enter>
map <F10> :DiffChangesDiffToggle<Enter>
map <F11> :w!<Enter>:!aspell check %<Enter>:w %<Enter>
map <F12> :SpellThis<Enter>
