" Personal vim configuration
" Maintainer:   Cluas <Cluas@live.cn>
" License:      MIT License

syntax on
filetype plugin indent on       " 打开文件类型检测

let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0

if empty(glob('~/.config/nvim/plugged'))
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/powerline'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'bufbuild/vim-buf'

Plug 'mbbill/undotree'

call plug#end()




