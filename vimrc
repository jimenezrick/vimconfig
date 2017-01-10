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

if $TERM == 'xterm-256color' || $TERM == 'rxvt-unicode-256color'
	colorscheme PaperColor
	set cursorline
endif

set nocompatible
set history=500
set title
set nobackup
set backspace=indent,eol,start
set relativenumber
set number
set ruler
set showmatch
set hlsearch
set autoindent
set incsearch
set ignorecase
set smartcase
set nowrap
set list
set listchars=tab:\|\ ,trail:·,precedes:<,extends:>
set foldmethod=indent
set foldnestmax=2
set nofoldenable
set completeopt=menuone
set wildmenu
set lazyredraw
set scrolloff=1
set sidescrolloff=6
set nospell
set spelllang=en,es
set path+=/usr/local/include,**
set pastetoggle=<F10>

autocmd BufEnter README,TODO,BUGS                 setlocal filetype=text
autocmd BufEnter PLAN,NOTES,*.notes               setlocal filetype=notes
autocmd BufEnter *.sls                            setlocal filetype=yaml

autocmd FileType c,cpp                            setlocal foldmethod=syntax cinoptions=(0,g0,N-s,:0,l1,t0 | compiler gcc
autocmd FileType go                               setlocal foldmethod=syntax formatoptions+=ro suffixesadd=.go
autocmd FileType haskell                          setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=2 foldmethod=indent
autocmd FileType cabal,yaml                       setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType text,notes,markdown,rst,tex,mail setlocal textwidth=72 formatoptions+=2l colorcolumn=+1 spell
autocmd FileType gitcommit                        setlocal spell
autocmd FileType help                             setlocal nospell

autocmd FileType haskell noremap <buffer> <silent> K :execute '!hoogle search --color --info' shellescape(expand('<cword>')) '\| less -R'<Enter>

" Clang plugin:
let clang_cpp_options = '-std=c++14 -stdlib=libc++'

" Syntastic plugin:
let syntastic_auto_loc_list = 1
let syntastic_mode_map      = {'mode': 'passive'}

let syntastic_cpp_compiler_options = '-std=c++14'
let syntastic_go_checkers          = ['go']

" Gutentags plugin:
let gutentags_ctags_executable_haskell = 'vim-hasktags'
let gutentags_ctags_executable_go      = 'vim-gotags'
let gutentags_project_info             = [
	\ {'type': 'haskell', 'glob': '*.cabal'},
	\ {'type': 'go', 'glob': '*.go'},
	\ {'type': 'go', 'glob': '*/*.go'},
\ ]

" Vim-go plugin:
let go_auto_type_info    = 1
let go_fmt_fail_silently = 1
let go_fmt_command       = 'goimports'

" haskell-vim plugin:
let haskell_enable_quantification = 1
let haskell_indent_if             = 4
let haskell_indent_case           = 4
let haskell_indent_in             = 0

" GHC-mod plugin:
autocmd FileType haskell noremap <buffer> <silent> <Leader>e :GhcModCheckAsync<Enter>
autocmd FileType haskell noremap <buffer> <silent> <Leader>t :GhcModType<Enter>

" Neco-GHC plugin:
let necoghc_enable_detailed_browse = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" CtrlP plugin:
let ctrlp_max_files  = 0
let ctrlp_extensions = ['tag', 'buffertag']

" Tagbar plugin:
let tagbar_type_haskell = {
	\ 'ctagstype' : 'haskell',
	\ 'ctagsbin'  : 'hasktags',
	\ 'ctagsargs' : '-x -c -o-',
	\ 'kinds'     : [
		\ 'm:modules:0:1',
		\ 'd:data: 0:1',
		\ 'd_gadt: data gadt:0:1',
		\ 't:type names:0:1',
		\ 'nt:new types:0:1',
		\ 'c:classes:0:1',
		\ 'cons:constructors:1:1',
		\ 'c_gadt:constructor gadt:1:1',
		\ 'c_a:constructor accessors:1:1',
		\ 'ft:function types:1:1',
		\ 'fi:function implementations:0:1',
		\ 'o:others:0:1'
	\ ],
	\ 'sro'        : '.',
	\ 'kind2scope' : {
		\ 'm' : 'module',
		\ 'c' : 'class',
		\ 'd' : 'data',
		\ 't' : 'type'
	\ },
	\ 'scope2kind' : {
		\ 'module' : 'm',
		\ 'class'  : 'c',
		\ 'data'   : 'd',
		\ 'type'   : 't'
	\ }
\ }

match Todo /TODO\|FIXME\|XXX\|FUCKME/

inoremap jk                <Esc>
inoremap kj                <Esc>:w<Enter>

noremap <C-j>              6j
noremap <C-k>              6k

noremap <silent> <C-Up>    :wincmd k<Enter>
noremap <silent> <C-Down>  :wincmd j<Enter>
noremap <silent> <C-Left>  :wincmd h<Enter>
noremap <silent> <C-Right> :wincmd l<Enter>

noremap <silent> <F1>      :NERDTreeToggle<Enter>
noremap <silent> <F2>      :write<Enter>
noremap <silent> <F3>      :nohlsearch<Enter>
noremap <silent> <F4>      :make<Enter>
noremap <silent> <F5>      :shell<Enter>
noremap <silent> <F6>      :if <SID>ToggleAutoHighlight()<Bar>set hlsearch<Bar>else<Bar>nohlsearch<Bar>endif<Enter>
noremap <silent> <F7>      :TagbarToggle<Enter>
noremap <silent> <F8>      :lvimgrep /TODO\\|FIXME\\|XXX\\|FUCKME/j %<Enter>:lopen<Enter>
noremap <silent> <F9>      :checktime<Enter>
noremap <silent> <F11>     :Spaces<Enter>
noremap <silent> <F12>     :SpellThis<Enter>

noremap <silent> <Leader>s :SyntasticToggleMode<Enter>

" Corrects current word spelling with the first suggestion
autocmd FileType text,notes,markdown,rst,tex,mail,gitcommit noremap <buffer> <silent> <Leader>s 1z=
" Formats current paragraph
autocmd FileType text,notes,markdown,rst,tex,mail,gitcommit noremap <buffer> <silent> <Leader>p gwap

" Open CtrlP in find buffer mode
noremap <silent> <Space> :CtrlPBuffer<Enter>
" Open location list window
noremap <silent> <Leader><Space> :lopen<Enter>

" Enter in interactive mode of EasyAlign plugin
vnoremap <silent> <Enter> :EasyAlign<Enter>

" Adds spaces around current block of lines
noremap <silent> <Leader><Enter> :call <SID>AddSpaces()<Enter>
" Removes spaces around current block of lines
noremap <silent> <Leader><BS>    :call <SID>RemoveSpaces()<Enter>
" Collapses current block of blank lines to one
noremap <silent> <Leader><Del>   :call <SID>CollapseSpaces()<Enter>

nnoremap <Leader>g :Grepper -open -switch<Enter>
nnoremap <Leader>* :Grepper -open -switch -cword<Enter>

" Shows double and trailing spaces
command Spaces silent normal / \{2}\|\s\+$\|\n\{3}/<Enter>

function s:AddSpaces() range
	let separation = 2
	let blanks     = repeat([''], separation)
	call append(a:lastline, blanks)
	call append(a:firstline - 1, blanks)
endfunction

function s:RemoveSpaces()
	if getline('.') == ''
		let fromline = prevnonblank(line('.')) + 1
		let toline   = nextnonblank(line('.')) - 1
		call s:DeleteLines(fromline, toline, 0)
		return
	endif

	let toline = search('^$', 'bnW')
	if toline != 0
		let fromline = prevnonblank(toline) + 1
		call s:DeleteLines(fromline, toline)
	endif

	let fromline = search('^$', 'nW')
	if fromline != 0
		let toline = nextnonblank(fromline) - 1
		call s:DeleteLines(fromline, toline)
	endif
endfunction

function s:CollapseSpaces()
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

function s:DeleteLines(fromline, toline, ...)
	let toline = a:toline < 1 ? line('$') : a:toline
	silent execute a:fromline . ',' . toline . 'delete'
	if a:0 == 0 || a:0 == 1 && a:1
		normal ``
	endif
endfunction

function s:ToggleAutoHighlight()
	if exists('#auto_highlight')
		autocmd! auto_highlight
		augroup! auto_highlight
		augroup END
		set updatetime&
		return 0
	else
		augroup auto_highlight
			autocmd!
			autocmd CursorHold * let @/ = '\V\<' . escape(expand('<cword>'), '\') . '\>'
		augroup END
		set updatetime=200
		return 1
	endif
endfunction
