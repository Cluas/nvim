
syntax on
call plug#begin('~/.local/share/nvim/plugged')

"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                " Project and file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plug 'majutsushi/tagbar'                  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'            " make statusline awesome
Plug 'vim-airline/vim-airline-themes'     " themes for statusline
Plug 'powerline/powerline'
Plug 'kien/ctrlp.vim'                     " fuzzy search files
Plug 'wsdjeg/FlyGrep.vim'                 " awesome grep on the fly
Plug 'tpope/vim-fugitive'                 " A Git wrapper so awesome
Plug 'mhinz/vim-startify'                 " The fancy start screen for Vim
Plug 'vim-python/python-syntax'
Plug 'w0ng/vim-hybrid'
"-------------------=== Languages support ===-------------------
Plug 'scrooloose/nerdcommenter'           " comment tools
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"-------------------=== Python  ===-----------------------------
"-------------------===  Auto-completion ===-----------------------------
Plug 'Valloric/YouCompleteMe'
" Plug 'honza/vim-snippets'
"-------------------=== Other ===-------------------------------
Plug 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
Plug 'kien/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'ryanoasis/vim-devicons'             " Dev Icons
Plug 'jiangmiao/auto-pairs'               " Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'mbbill/undotree'                    " The undo history visualizer
Plug 'ybian/smartim'
call plug#end()
" path to your python

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = "/usr/local/bin/python"
let g:python_highlight_all = 1
let g:startify_change_to_dir = 0
let g:deoplete#enable_at_startup = 1
set completeopt+=noselect
filetype indent on
set nu

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

set clipboard=unnamedplus

set undodir=$HOME/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" toggle nerdtree on ctrl+n
map <C-n> :NERDTreeToggle<CR>
map <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>


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

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"


" FlyGrep settings
nnoremap <leader>s :FlyGrep<cr>

" ctrl p options
let g:ctrlp_custom_ignore = '\v\.(npy|jpg|pyc|so|dll)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_window       = 'bottom,order:btt,min:5,max:5,results:10'
let g:ctrlp_cmd                = 'CtrlPMixed'
let g:ctrlp_mruf_default_order = 1

"" NERDTree settings
let NERDTreeIgnore = [
			\ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.pyo$', '\.svn$', '\.swp$',
			\ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.ropeproject$', '\.pytest_cache$' ]


let g:NERDTreeShowHidden          = 0
let g:NERDTreeMinimalUI           = 1
let g:NERDTreeShowFiles           = 1
let g:NERDTreeDirArrows           = 1
let NERDTreeWinSize=40
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

"
let g:go_version_warning = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:deoplete#sources#go#gocode_binary = '~/go/bin/gocode'
let g:go_def_mode = 'gopls'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
