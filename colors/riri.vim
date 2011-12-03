" Vim color file
" Author:  Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" Version: 2011/12/01
"
" Color scheme for 256 colors terminals

set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "riri"

hi Normal       ctermfg=black    ctermbg=254
hi ErrorMsg     ctermfg=NONE     ctermbg=220
hi NonText      ctermfg=blue
hi LineNr       ctermfg=darkblue
hi StatusLine   ctermfg=white    ctermbg=125 cterm=bold
hi StatusLineNC ctermfg=white    ctermbg=125 cterm=reverse

hi Comment      ctermfg=darkblue
hi String       ctermfg=160
hi Number       ctermfg=27
hi Constant     ctermfg=163
hi Statement    ctermfg=16       cterm=bold
hi PreProc      ctermfg=blue
hi Type         ctermfg=28
hi StorageClass ctermfg=red
hi Special      ctermfg=darkcyan
hi Function     ctermfg=red
hi Error        ctermbg=160
hi Todo         ctermbg=120
hi Search       ctermfg=white    ctermbg=162
hi ColorColumn  ctermbg=195

if version >= 700
	hi MatchParen ctermbg=81

	hi SpellBad  ctermfg=red     ctermbg=NONE cterm=underline
	hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
	hi SpellCap  ctermfg=blue    ctermbg=NONE cterm=underline

	hi Pmenu     ctermfg=125 ctermbg=white cterm=NONE
	hi PmenuSel  ctermfg=125 ctermbg=white cterm=reverse
	hi PmenuSbar ctermfg=252 ctermbg=white cterm=reverse

	hi TabLine     ctermfg=125 ctermbg=white cterm=NONE
	hi TabLineSel  ctermfg=125 ctermbg=white cterm=reverse
	hi TabLineFill ctermfg=252 ctermbg=white cterm=reverse
endif
