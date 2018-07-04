function! s:GetExecutable(buffer) abort
	if empty(glob('*.cabal', v:true, v:true))
		return ""
	endif
	return "cabal"
endfunction

call ale#linter#Define('haskell', {
\   'name': 'cabal-repl',
\   'output_stream': 'stderr',
\   'executable_callback': function('s:GetExecutable'),
\   'command': "echo :quit | cabal new-repl -v0",
\   'lint_file': 1,
\   'callback': 'ale#handlers#haskell#HandleGHCFormat',
\})
