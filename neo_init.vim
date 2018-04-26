call plug#begin()
Plug 'rust-lang/rust.vim' 

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
Plug 'ervandew/supertab'
Plug 'roxma/nvim-completion-manager'

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neomake/neomake'

call plug#end()

"set background=dark

set hidden

" let g:LanguageClient_selectionUI = "location-list"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['/usr/bin/pyls'],
    \ }

" \ 'javascript' : ['/home/anton/.nvm/versions/node/v8.5.0/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" let g:rustfmt_autosave = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let mapleader=","

nmap <C-t> :GFiles<CR>

" Rust sper
nnoremap <leader>r :!cargo run --release \| less<CR>
nnoremap <leader>t :!cargo test \| less<CR>
nnoremap <leader>l :write<CR> :!cargo fmt<CR> :edit <CR>

nnoremap <leader>p :!perl % <CR>

let g:SuperTabDefaultCompletionType = "<c-n>"
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


call neomake#configure#automake('nw', 1000)
