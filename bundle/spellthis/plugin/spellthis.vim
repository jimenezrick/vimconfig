" Vim plugin file
" Author:        Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" Version:       0.5
" Last Modified: Sun Apr 10 22:54:52 CEST 2011
" Description:
"   Simple script to check the spelling of the word under the cursor with
"   Aspell. Useful to check variable names when programming. It supports names
"   with camelcase and underscores.

" Do not load if it is already loaded or we are in `compatible mode'
if exists("g:loaded_spellthis") || &cp
	finish
endif

let g:loaded_spellthis=1
let s:default_spell_lang="en"

" Create new user commands, use `:SpellThis' or `:SpellThisAs {lang}'
command -nargs=0 SpellThis call s:Spell_This()
command -nargs=1 SpellThisAs call s:Spell_This_As(<f-args>)

function s:Spell_This()
	call s:Spell_This_As(s:default_spell_lang)
endfunction

function s:Spell_This_As(lang)
	let l:spell_lang=a:lang
	let l:current_words=tolower(s:split_word(expand("<cword>")))
	let l:cmd_list=printf("echo %s|aspell list --lang=%s|wc -w", l:current_words, l:spell_lang)
	let l:cmd_pipe=printf("echo %s|aspell pipe --lang=%s", l:current_words, l:spell_lang)
	let l:bad_words=str2nr(system(l:cmd_list))

	if l:bad_words == 0
		if exists("s:scratch_buffer") && exists("s:scratch_buffer_loaded")
			unlet s:scratch_buffer_loaded
			execute "bunload" s:scratch_buffer
		endif
		echo "Correct spelling"
	else
		let l:cmd_output=system(l:cmd_pipe)
		call s:create_scratch_buffer(l:bad_words)
		execute "normal i" . l:cmd_output
		1delete
		$-1,$delete
		call s:clean_results()
	endif
endfunction

function s:split_word(word)
	return substitute(s:convert_from_camelcase(a:word), "_", " ", "g")
endfunction

function s:convert_from_camelcase(word)
	return join(split(a:word, '\ze\u\l'), "_")
endfunction

function s:create_scratch_buffer(size)
	if exists("s:scratch_buffer")
		below split
		execute "buffer" s:scratch_buffer
		1,$delete
	else
		below new
		autocmd BufLeave <buffer> hide
		let s:scratch_buffer=bufnr("%")
	endif
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	execute "resize" a:size
	let s:scratch_buffer_loaded=1
endfunction

function s:clean_results()
	normal gg
	while 1
		let l:current_line=getline(".")
		if match(l:current_line, "*") == 0
			.delete
		elseif match(l:current_line, "&") == 0
			normal xxwdwdwhx
		elseif line(".") < line("$")
			normal j0
		elseif line(".") == line("$")
			break
		endif
	endwhile
	normal gg
endfunction
