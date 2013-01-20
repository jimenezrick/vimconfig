" Vim syntax file
" Language: Notes
" Author:   Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" Version:  Sun Jan 20 00:28:04 CET 2013

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'notes'
set conceallevel=2

highlight! link Conceal Comment

syntax match heading /^\S.*/
highlight link heading Special

syntax match item /^\s*\zs-\ze\s/
highlight link item Comment

syntax match item2 /^\s*\zs+\ze\s/ conceal cchar=•
highlight link item2 Comment

syntax match numberedItem /^\s*\zs\d\+\.\?\ze\s/
highlight link numberedItem Comment

syntax match emphasis /\*.\+\*/ contains=emphasisMark
syntax match emphasisMark contained /\*/ conceal
highlight emphasis cterm=bold

syntax match ruler /^-\{3,}$/ contains=rulerSymbol
syntax match rulerSymbol contained /-/ conceal cchar=━
highlight link rulerSymbol Comment

syntax match ruler2 /^=\{3,}$/ contains=ruler2Symbol
syntax match ruler2Symbol contained /=/ conceal cchar=▬
highlight link ruler2Symbol Comment

syntax match url /http\(s\)\?:\/\/\S\+/
highlight link url Underlined
