" airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

" gitgutter
nmap ]p :GitGutterNextHunk<CR>
nmap [p :GitGutterPrevHunk<CR>

" fzf
source ~/.vim/plugged/fzf/plugin/fzf.vim
nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><leader>f :GFiles<CR>
nnoremap <silent><leader>c :Lines<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <silent><leader>d :NERDTreeToggle<CR>
