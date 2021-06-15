let g:ale_linters = {
   \'python': [],
\   'proto': ['buf-check-lint'],
   \}
let g:ale_fixers = {
   \'python': ['black', 'isort'],
   \'sql': ['sqlformat'],
   \'*': ['remove_trailing_lines', 'trim_whitespace'],
   \'txt':['align_help_tags'],
   \'go': ['goimports'],
   \'json': ['prettier'],
   \}
let g:ale_python_black_options='-t py27 -l 120 --fast'
let g:ale_python_isort_options='-e --multi-line=3 -tc --line-width=120'
let g:ale_sql_sqlformat_options="-k upper -a -s""
nmap <leader>f :ALEFix<CR>