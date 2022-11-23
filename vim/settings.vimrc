set nocompatible

filetype plugin indent on
syntax on

" Set line numbers on by default
set number

nnoremap J <PageDown>
nnoremap K <PageUp>

let g:dracula_colorterm = 0
colorscheme dracula

" Cscope
source ${HOME}/.cscope_maps.vim
