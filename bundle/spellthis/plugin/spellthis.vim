" ----------------------------------------------------------------------------
" File: spellthis.vim
" Author: Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" Version: 0.4.1
" Last Modified: Tue Aug  3 18:56:15 CEST 2010
"
" Description:
"   Simple script to check the spelling of the word under the cursor with
"   Aspell. Useful to check variable names when programming. It supports names
"   with camelcase or underscores.
"
" Copyright:
"              DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                      Version 2, December 2004
"
"   Copyright (C) 2004 Sam Hocevar
"    14 rue de Plaisance, 75014 Paris, France
"   Everyone is permitted to copy and distribute verbatim or modified
"   copies of this license document, and changing it is allowed as long
"   as the name is changed.
"
"              DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"     TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"    0. You just DO WHAT THE FUCK YOU WANT TO.
"
" ----------------------------------------------------------------------------

" Do not load if it is already loaded or we are in `compatible mode'
if exists("g:loaded_spellthis") || &cp
	finish
endif

let g:loaded_spellthis=1
let s:default_spell_lang="en"

" Create new user commands, do: `:SpellThis' or `:SpellThisAs {lang}'
command -nargs=0 SpellThis call s:Spell_This()
command -nargs=1 SpellThisAs call s:Spell_This_As(<f-args>)

" If there is GUI running, add the menu entry
if has("gui_running")
	menu Plugin.SpellThis :SpellThis<Enter>
endif

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
	if match(a:word, "_") != -1
		return substitute(a:word, "_", " ", "g")
	else
		return s:convert_from_camelcase(a:word)
	endif
endfunction

function s:convert_from_camelcase(word)
	return join(split(a:word, '\ze\u\l'), " ")
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
