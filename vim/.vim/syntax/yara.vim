" Vim syntax file for yara rules
" Language:     yara
" Maintainer:   earada <earada@alienvault.com>
" Updated By:   rmbreak
" Last Change:  2015 April 24

syn match       num         "\<[0-9]\+\(KB\|MB\)\=\>"
syn match       numhex      "\<0x[0-9a-fA-F]\+\>"
syn match       variable    "[\$@#]\([0-9a-zA-Z_]\+\*\=\)\="
syn match       bytes       "{\s*\(\([0-9a-fA-F?]\{2\}\)\|\(\[[0-9a-fA-F-]*\]\)\|\((\([0-9a-fA-F?]\{2\}\||\|\s\)*)\)\|\s\)*}"
syn match       contains    "\<contains\>"

syn region      comments    start="\/\/" skip="\\$" end="$"
syn region      comments    start="\/\*" skip="\\$" end="\*\/"
syn region      strings     start="\"" end="\""
syn region      regex       start="\/[^\/\*]" skip="\\/" end="\/"

syn keyword     rules       rule private global include
syn keyword     sections    condition strings meta
syn keyword     casts       int8 int16 int32 uint8 uint16 uint32 int8be int16be int32be uint8be uint16be uint32be
syn keyword     operand     in and at or not of false true
syn keyword     res_word    all any ascii entrypoint filesize for fullword import index index indexes indexes matches nocase rva rva section section them wide

hi def link     variable    Keyword
hi def link     res_word    Keyword
hi def link     strings     String
hi def link     bytes       String
hi def link     rules       Identifier
hi def link     sections    Identifier
hi def link     regex       String
hi def link     operand     Conditional
hi def link     casts       Function
hi def link     comments    Comment
hi def link     numhex      Number
hi def link     num         numhex
hi def link     contains    res_word
