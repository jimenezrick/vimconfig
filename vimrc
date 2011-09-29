" IMPORTANT: Pathogen must start with filetype detection disabled
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
set scrolloff=1
set sidescrolloff=6
set nospell
set spelllang=es,en

autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax foldnestmax=2 cinoptions=h0
autocmd FileType erlang setlocal foldmethod=expr expandtab tabstop=4 shiftwidth=4
autocmd FileType python setlocal foldmethod=indent
autocmd FileType haskell,ocaml setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType tex,mail setlocal textwidth=72 spell
autocmd BufNewFile,BufRead README,*.txt,*.markdown,*.md setlocal textwidth=72 colorcolumn=+1 spell

" Use omni completion with `CTRL-X + CTRL-O', create the system tags file with:
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/systags /usr/include /usr/local/include
autocmd FileType c,cpp setlocal tags+=~/.vim/systags
autocmd FileType cpp setlocal tags+=~/.vim/bundle/tags-cpp-stl/tags-cpp-stl

" Vimerl customization
let erlang_show_errors = 0
let erlang_man_path    = '/usr/local/lib/erlang/man'
let erlang_skel_header = {'author': 'Ricardo Catalinas Jiménez <jimenezrick@gmail.com>',
		       \  'owner' : 'Ricardo Catalinas Jiménez'}

" Tag List customization
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Enable_Fold_Column      = 0
let Tlist_Use_Right_Window        = 1
let Tlist_Exit_OnlyWindow         = 1
let tlist_ocaml_settings          = 'ocaml;c:class;m:object method;M:module;v:global scope;t:type;' .
				  \ 'f:function;C:constructor;r:structure field;e:exception'

" Syntastic customization
let syntastic_enable_signs       = 1
let syntastic_auto_loc_list      = 1
let syntastic_disabled_filetypes = ['c', 'cpp', 'erlang', 'python', 'haskell', 'ocaml', 'tex', 'sh']

match Todo /TODO\|FIXME\|XXX\|FUCKME/

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

" Corrects current word spelling with the first suggestion
map <Leader>s 1z=
" Formats current paragraph
map <Leader>p gwap
" Adds spaces around current block of lines
map <silent> <Leader><Space> :call <SID>AddSpaces()<Enter>
" Removes spaces around current block of lines
map <silent> <Leader><BS>    :call <SID>RemoveSpaces()<Enter>
" Collapses current block of blank lines to one
map <silent> <Leader><Del>   :call <SID>CollapseSpaces()<Enter>

function <SID>AddSpaces() range
	let separation = 2
	let blanks     = repeat([''], separation)
	call append(a:lastline, blanks)
	call append(a:firstline - 1, blanks)
endfunction

function <SID>RemoveSpaces()
	if getline('.') == ''
		let fromline = prevnonblank(line('.')) + 1
		let toline   = nextnonblank(line('.')) - 1
		call s:DeleteLines(fromline, toline)
		return
	endif

	let toline = search('^$', 'bn')
	if toline != 0
		let fromline = prevnonblank(toline) + 1
		call s:DeleteLines(fromline, toline)
	endif

	let fromline = search('^$', 'n')
	if fromline != 0
		let toline = nextnonblank(fromline) - 1
		call s:DeleteLines(fromline, toline)
	endif
endfunction

function <SID>CollapseSpaces()
	if getline('.') != ''
		return
	endif

	if line('.') > 1 && getline(line('.') - 1) == ''
		let toline   = line('.') - 1
		let fromline = prevnonblank(toline) + 1
		call s:DeleteLines(fromline, toline)
	endif

	if line('.') < line('$') && getline(line('.') + 1) == ''
		let fromline = line('.') + 1
		let toline   = nextnonblank(fromline) - 1
		call s:DeleteLines(fromline, toline)
	endif
endfunction

function s:DeleteLines(fromline, toline)
	mark `
	silent execute a:fromline . ',' . a:toline . 'delete'
	normal g``
	mark `
endfunction
