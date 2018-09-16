call plug#begin()
Plug 'rust-lang/rust.vim' 

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
Plug 'ervandew/supertab'

" A dependency of 'ncm2'.
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'thaerkh/vim-indentguides'

Plug 'neomake/neomake'

call plug#end()

"set background=dark

set hidden

autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" set completeopt=noinsert,menuone,noselect
"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" let g:LanguageClient_selectionUI = "location-list"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rls'],
    \ 'python': ['/usr/bin/pyls'],
    \ }

" \ 'javascript' : ['/home/anton/.nvm/versions/node/v8.5.0/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" let g:rustfmt_autosave = 1


let mapleader=","

nmap <C-t> :GFiles<CR>

" Rust sper
nnoremap <leader>r :!cargo run --release \| less<CR>
nnoremap <leader>t :!cargo test \| less<CR>

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <C-m> :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>l :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <C-p> :call LanguageClient_workspace_symbol()<CR>
nnoremap <silent> <A-cr> :call LanguageClient_textDocument_codeAction()<CR>


" let g:SuperTabDefaultCompletionType = "<c-n>"
map <C-n> :NERDTreeToggle<CR>

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr><Paste>

call neomake#configure#automake('nw', 750)
