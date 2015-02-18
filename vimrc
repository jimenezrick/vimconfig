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
	colorscheme riri
	set cursorline
endif

set nocompatible
set history=500
set title
set nobackup
set backspace=indent,eol,start
set relativenumber
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
set spelllang=es,en
set path+=/usr/local/include,**
set pastetoggle=<F10>

autocmd BufEnter README,TODO,BUGS                 setlocal filetype=text
autocmd BufEnter PLAN,NOTES,*.notes               setlocal filetype=notes
autocmd BufEnter *.md                             setlocal filetype=markdown
autocmd BufEnter *.cql                            setlocal filetype=cql

autocmd FileType c,cpp                            setlocal foldmethod=syntax cinoptions=(0,g0,N-s,:0,l1,t0 | compiler gcc
autocmd FileType go                               setlocal foldmethod=syntax formatoptions+=ro suffixesadd=.go
autocmd FileType scala                            setlocal expandtab tabstop=2 shiftwidth=2 path-=**
autocmd FileType haskell,erlang                   setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType haskell,python                   setlocal foldmethod=indent
autocmd FileType haskell                          setlocal comments=s1fl:{-,mb:\ ,ex:-},:--
autocmd FileType cabal                            setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType text,notes,markdown,rst,tex,mail setlocal textwidth=72 formatoptions+=2l colorcolumn=+1 spell
autocmd FileType gitcommit                        setlocal spell
autocmd FileType help                             setlocal nospell

" C plugin:
let c_no_curly_error = 1 " For C++11 lambdas

" Clang Complete plugin:
let clang_use_library     = 1
let clang_complete_auto   = 0
let clang_complete_macros = 1
let clang_complete_copen  = 1
autocmd FileType c,cpp highlight clear SpellBad   | highlight SpellBad ctermfg=white ctermbg=red
autocmd FileType c,cpp highlight clear SpellLocal | highlight SpellLocal ctermfg=white ctermbg=blue
autocmd FileType c,cpp noremap <buffer> <silent> <Leader>e :call g:ClangUpdateQuickFix()<Enter>

" Go plugin:
if executable('goimports')
	let gofmt_command = 'goimports'
endif
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Vimerl plugin:
let erlang_folding     = 1
let erlang_show_errors = 0
let erlang_skel_header = {'author': 'Ricardo Catalinas Jiménez <jimenezrick@gmail.com>',
		       \  'owner' : 'Ricardo Catalinas Jiménez'}

" Syntastic plugin:
let syntastic_auto_loc_list = 1
let syntastic_mode_map      = {'mode': 'passive'}

" haskell-vim plugin:
let haskell_enable_quantification = 1
let haskell_indent_if             = 4
let haskell_indent_case           = 4
let haskell_indent_in             = 0

" GHC-mod plugin:
autocmd FileType haskell noremap <buffer> <silent> <Leader>e :GhcModCheck<Enter>
autocmd FileType haskell noremap <buffer> <silent> <Leader>t :GhcModType<Enter>

" Neco-GHC plugin:
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" CtrlP plugin:
let ctrlp_max_files  = 0
let ctrlp_extensions = ['tag', 'buffertag']

" Tagbar plugin:
let tagbar_type_go = {
	\ 'ctagstype': 'Go',
	\ 'kinds'    : [
		\ 'p:packages',
		\ 'f:functions',
		\ 'v:variables',
		\ 't:types',
		\ 'c:constants'
	\ ]
\ }

match Todo /TODO\|FIXME\|XXX\|FUCKME/

inoremap jk                <Esc>

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

" Corrects current word spelling with the first suggestion
noremap <silent> <Leader>s 1z=
" Formats current paragraph
noremap <silent> <Leader>p gwap

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

let &grepprg = 'grep -nH -C5 -rIs --exclude-dir=.git --exclude-dir=.hg --exclude=tags $*'
" Searches current word recursively in the current directory
noremap <silent> <Leader>g :silent execute 'lgrep! -Fw' shellescape(expand('<cword>')) '.' <Bar> lopen <Bar> redraw!<Enter>
" :Grep <pattern> [<file>...]
command -nargs=+ -complete=file Grep silent lgrep! -E <args> | lopen | redraw!

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
