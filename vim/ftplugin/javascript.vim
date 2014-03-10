setlocal ts=2
setlocal sw=2

nnoremap <localleader>'" :s/'/"/g<cr>
nnoremap <localleader>"' :s/"/'/g<cr>
noremap <localleader>t: :Tabularize /^[^:]*\zs:<cr>
