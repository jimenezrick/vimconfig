" Author: w0rp <devw0rp@gmail.com>
" Description: ghc for Haskell files

function! s:GetExecutable(buffer) abort
	if !empty(glob('*.cabal', v:true, v:true))
		return ""
	endif
	return "ghc"
endfunction

call ale#Set('haskell_ghc_options', '-fno-code -v0')

function! ale_linters#haskell#ghc#GetCommand(buffer) abort
    return 'ghc '
    \   . ale#Var(a:buffer, 'haskell_ghc_options')
    \   . ' %t'
endfunction

call ale#linter#Define('haskell', {
\   'name': 'my-ghc',
\   'output_stream': 'stderr',
\   'executable_callback': function('s:GetExecutable'),
\   'command_callback': 'ale_linters#haskell#ghc#GetCommand',
\   'callback': 'ale#handlers#haskell#HandleGHCFormat',
\})
