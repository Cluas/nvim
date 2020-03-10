scriptencoding 'utf8'
syntax on
call plug#begin()

Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/powerline'
Plug 'mhinz/vim-startify'
Plug 'w0ng/vim-hybrid'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'dense-analysis/ale'
Plug 'w0ng/vim-hybrid'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/vader.vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'bronson/vim-trailing-whitespace'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'chemzqm/wxapp.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()

let g:python3_host_prog = '/Users/cluas/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = '/Users/cluas/.pyenv/versions/neovim2/bin/python'
let g:python_highlight_all = 1
let g:startify_change_to_dir = 1
nmap <silent> <leader>d <Plug>(pydocstring)
set completeopt+=noselect
set nocursorline
filetype indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set number
set noshowcmd
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

set clipboard=unnamedplus

set undodir=$HOME/.vim/undo/
set undofile
set undolevels=500
set undoreload=5000

set scrolloff=1

set background=dark
"colorscheme dracula
"let g:hybrid_custom_term_colors = 1
"let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"if (has('termguicolors')) && $TERM_PROGRAM ==# 'iTerm.app'
  "set t_8f=^[[38;2;%lu;%lu;%lum
  "set t_8b=^[[48;2;%lu;%lu;%lum
  "set termguicolors
"endif


set pumheight=5

" For startify
let s:header = [
              \ '+-------------------------------------------+',
              \ '|                   ^_^                     |',
              \ '|               Clean Code.                 |',
              \ '|                                           |',
              \ '|     GitHub: https://github.com/Cluas      |',
              \ '+-------------------------------------------+',
              \ ]

function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)

map - :NERDTreeToggle<CR>

let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
" coc.nvim setup ============================================================{{{

" color for cursor holding highlight
"hi default CocHighlightText guibg=#8a8a8a guifg=#211F1C

" color for coc-diagnostic
hi link CocErrorSign Error
hi link CocWarningSign ALEWarningSign

" }}}
"
" Show git diff
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
nnoremap <leader>gs :GitGutterToggle<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
" }}}

set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}

" FZF ======================================================================={{{
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" Ag grep
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
" Rg grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <C-p> :FZF<CR>
nnoremap <leader>bt :BTags<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>bf :Buffers<CR>
"}}}

" Golang ===================================================================={{{
" enrich highlighting
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = 'goimports'
let g:go_metalinter_command = 'golangci-lint'
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:go_auto_sameids = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" }}}
" Linters ==================================================================={{{
" fixters
let g:ale_linters = {
   \'python': [],
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
" }}}

" coc.nvim =================================================================={{{
" Installed extensions:
" coc-lists
" coc-snippets
" coc-highlight
" coc-yaml
" coc-python
" coc-json
" coc-git
" Smaller updatetime for CursorHold & CursorHoldI
"f hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" popup
nmap <Leader>t <Plug>(coc-translator-p)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
" replace
nmap <Leader>r <Plug>(coc-translator-r)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR>

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>ff :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" }}}

" Ultimate Snippet =========================================================={{{
" Snippets are separated from the engine. Add this if you want them:
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
" }}}

" FZF ======================================================================={{{
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" Ag grep
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
" Rg grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <C-p> :FZF<CR>
nnoremap <leader>rg :Rg<space>
nnoremap <leader>bt :BTags<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>bf :Buffers<CR>
"}}}
