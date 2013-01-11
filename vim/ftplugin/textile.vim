set wrap
set linebreak
set nolist
set spell


syn match link /http\S\+/ contains=@NoSpell
" Not ideal because the text isn't spell checked
syn match txtLink /"[^"]\+":\(\([^:\/?# ]\+\):\)\?\(\/\/\([^\/?# ]*\)\)\?\([^?# ]*\)\(?\([^# ]*\)\)\?\(#\([^ ]*\)\)\?/ contains=@NoSpell

syn match oldetc /&c/ contains=@NoSpell
