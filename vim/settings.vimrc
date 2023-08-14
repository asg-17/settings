set nocompatible

filetype plugin indent on
syntax on

" Set line numbers on by default
set number

" Highlight the current line.
set cursorline

" Allow vim to use the X clipboard.
set clipboard=unnamed

" Folding based on syntax
" By default all folds open
set foldmethod=syntax
set foldlevel=99

nnoremap J <PageDown>
nnoremap K <PageUp>

let g:dracula_colorterm = 0
colorscheme dracula

" Cscope
source ${HOME}/.cscope_maps.vim
