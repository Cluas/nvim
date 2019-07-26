syntax on
call plug#begin()

Plug 'majutsushi/tagbar'                  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'            " make statusline awesome
Plug 'vim-airline/vim-airline-themes'     " themes for statusline
Plug 'powerline/powerline'
Plug 'tpope/vim-fugitive'                 " A Git wrapper so awesome
Plug 'mhinz/vim-startify'                 " The fancy start screen for Vim
Plug 'w0ng/vim-hybrid'
Plug 'scrooloose/nerdcommenter'           " comment tools
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
Plug 'jiangmiao/auto-pairs'               " Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'mbbill/undotree'                    " The undo history visualizer
Plug 'w0rp/ale'
Plug 'heavenshell/vim-pydocstring'
Plug 'bronson/vim-trailing-whitespace'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

let g:python3_host_prog = '/Users/cluas/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = "/Users/cluas/.pyenv/versions/neovim2/bin/python"
let g:python_highlight_all = 1
let g:startify_change_to_dir = 1
nmap <silent> <leader>d <Plug>(pydocstring)
set completeopt+=noselect
filetype indent on
set nu

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"
set encoding=utf-8

set clipboard=unnamedplus

set undodir=$HOME/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000



set background=dark
colorscheme hybrid
let g:hybrid_custom_term_colors = 1
let g:airline_theme = "hybrid"
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set pumheight=5

" For startify
let s:header = [
	      \ '',
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

" Defx setup ================================================================{{{

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })
call defx#custom#column('filename', {
      \ 'min_width': 40,
      \ 'max_width': 40,
      \ })
call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })
call defx#custom#option('_', {
      \ 'winwidth': 35,
      \ 'columns': 'git:mark:indent:icons:filename:type',
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'ignored_files': '.*,*.pyc'
      \ })

" }}}

" coc.nvim setup ============================================================{{{

" color for cursor holding highlight
hi default CocHighlightText guibg=#8a8a8a guifg=#211F1C
let g:airline#extensions#coc#enabled = 1

" color for coc-diagnostic
hi link CocErrorSign Error
hi link CocWarningSign ALEWarningSign

" }}}
"


" Remove trailing whitespaces
map <leader><space> :FixWhitespace<cr>
let g:extra_whitespace_ignored_filetypes = ['defx']

" Show git diff
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
nnoremap <leader>gs :GitGutterToggle<CR>
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


" Defx ======================================================================{{{
map <silent> - :Defx<CR>
" Avoid the white space highting issue
autocmd FileType defx match ExtraWhitespace /^^/
" Keymap in defx
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  "IndentLinesDisable
  setl nospell
  setl signcolumn=no
  setl nonumber
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop',)
  nmap <silent><buffer><expr> <2-LeftMouse>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop',)
  nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
  nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> C defx#do_action('copy')
  nnoremap <silent><buffer><expr> P defx#do_action('paste')
  nnoremap <silent><buffer><expr> M defx#do_action('rename')
  nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

" Defx git
let g:defx_git#indicators = {
  \ 'Modified'  : '•',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1

" }}}

" Golang ===================================================================={{{
" enrich highlighting
let g:go_def_mapping_enabled = 0
" }}}


" Linters ==================================================================={{{
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_python_black_options="-t py27 -l 120 --fast"
let g:ale_python_isort_options="-e -m 4 -w 120"



" virtual text, conflicts with coc-git
"let g:ale_virtualtext_cursor = 1
"let g:ale_virtualtext_prefix = ' > '
nmap <leader>f :ALEFix<CR>
"hi link ALEError ALEErrorSign
"hi link ALEWarning ALEWarningSign

" }}}

" coc.nvim =================================================================={{{
" Installed extensions:
" coc-lists
" coc-snippets
" coc-highlight
" coc-yaml
" coc-python
" coc-json
" coc-html
" coc-css
" coc-vimlsp
" coc-tsserver
" coc-tslint-plugin
" coc-pairs
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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" }}}

" Ultimate Snippet =========================================================={{{
" Snippets are separated from the engine. Add this if you want them:
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
