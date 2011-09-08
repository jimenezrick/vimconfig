" IMPORTANT: Uncomment if necessary, Vim must start with filetype disabled
"filetype off

source ~/.vim/bundle/pathogen/autoload/pathogen.vim

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set guioptions+=c
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R

if split(system('uname'))[0] == 'Darwin'
	set guifont=Monaco:h10
elseif $TERM =~ 'xterm'
	set t_Co=256
	colorscheme zenburn
elseif $TERM =~ 'rxvt-unicode'
	colorscheme miromiro
endif

autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax foldnestmax=2 cinoptions=h0
autocmd FileType erlang setlocal foldmethod=expr expandtab tabstop=4 shiftwidth=4
autocmd FileType python setlocal foldmethod=indent
autocmd FileType haskell,ocaml setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType tex,mail setlocal textwidth=72 spell
autocmd BufNewFile,BufRead README,*.txt,*.markdown,*.md setlocal textwidth=72 colorcolumn=+1 spell

" Vimerl customization
let erlangHighlightBIFs = 1
let erlangManPath       = '/usr/local/lib/erlang/man'

" Tag List customization
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Enable_Fold_Column      = 0
let Tlist_Use_Right_Window        = 1
let Tlist_Exit_OnlyWindow         = 1
let tlist_ocaml_settings          = 'ocaml;c:class;m:object method;M:module;v:global scope;t:type;' .
				  \ 'f:function;C:constructor;r:structure field;e:exception'

" Use Omni completion with `CTRL-X + CTRL-O', create the system tags file with:
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/systags /usr/include /usr/local/include
set tags+=~/.vim/systags
set tags+=~/.vim/bundle/tags-cpp-stl/tags-cpp-stl

set nocompatible
set history=100
set title
set nobackup
set backspace=indent,eol,start
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
set wildmenu
set lazyredraw
set scrolloff=2
set sidescroll=1
set sidescrolloff=6
set nospell
set spelllang=es,en

match Todo /TODO\|FIXME\|XXX\|FUCKME/

" Adds/removes spaces around current block of lines
map <Leader><Space> 2O<ESC>j2o<ESC>2k
map <Leader><BS>    {:?.?+1,.d<Enter>}:.,/./-1d<Enter>:nohlsearch<Enter>k
" Collapses current block of blank lines to one
map <Leader>d       :?.?+1,-1d<Enter>:+1,/./-1d<Enter>:nohlsearch<Enter>k
" Corrects current word spelling with the first suggestion
map <Leader>s       1z=
" Formats current paragraph
map <Leader>p       gwap

map <F1>  :NERDTreeToggle<Enter>
map <F2>  :write<Enter>
map <F3>  :nohlsearch<Enter>
map <F4>  :make<Enter>
map <F5>  :shell<Enter>
map <F6>  :TlistToggle<Enter>
map <F7>  :TagbarToggle<Enter>
map <F8>  :vimgrep /TODO\\|FIXME\\|XXX\\|FUCKME/ %<Enter>:copen<Enter>
map <F9>  :checktime<Enter>
map <F10> :DiffChangesDiffToggle<Enter>
map <F11> :w!<Enter>:!aspell check %<Enter>:w %<Enter>
map <F12> :SpellThis<Enter>
