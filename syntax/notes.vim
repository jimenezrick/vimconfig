" Vim syntax file
" Language: Notes
" Author:   Ricardo Catalinas Jiménez <r@untroubled.be>
" Version:  Sat Oct 20 12:28:38 UTC 2018

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'notes'
set conceallevel=2

highlight! link Conceal Comment

syntax match heading /^\S.*/ contains=headingSection
highlight heading cterm=bold
syntax match headingSection contained /#/ conceal cchar=§

syntax match item /^\s*\zs-\ze\s/ conceal cchar=─

syntax match item2 /^\s*\zs+\ze\s/ conceal cchar=●

syntax match numberedItem /^\s*\zs\d\+\.\?\ze\s/
highlight numberedItem cterm=bold

syntax match code /^|.*/
highlight code cterm=bold

syntax match emphasis /\*.\{-1,}\*/ contains=emphasisMark
highlight emphasis cterm=bold
syntax match emphasisMark contained /\*/ conceal

syntax region emphasisBlock matchgroup=Conceal concealends start='\*' end='\*'
highlight emphasisBlock cterm=bold

syntax match ruler /^-\{3,}$/ contains=rulerSymbol
syntax match rulerSymbol contained /-/ conceal cchar=─

syntax match ruler2 /^=\{3,}$/ contains=ruler2Symbol
syntax match ruler2Symbol contained /=/ conceal cchar=━

syntax match url /http\(s\)\?:\/\/\S\+/
highlight link url Underlined

syntax match itemDone /\<DONE\>/
highlight itemDone cterm=bold ctermfg=green

syntax match itemInProgress /\<WIP\>/
highlight itemInProgress cterm=bold ctermfg=yellow
