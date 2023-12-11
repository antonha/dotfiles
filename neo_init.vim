call plug#begin()
Plug 'rust-lang/rust.vim' 

"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'Shougo/denite.nvim'

"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
"Plug 'ervandew/supertab'

" A dependency of 'ncm2'.
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2'

"Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'thaerkh/vim-indentguides'

" Plug 'neomake/neomake'
Plug 'morhetz/gruvbox'

"Plug 'sakhnik/nvim-gdb'

"Plug 'hashivim/vim-terraform'


call plug#end()

set background=dark

set hidden

autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" set completeopt=noinsert,menuone,noselect
"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" let g:LanguageClient_selectionUI = "location-list"

let mapleader=","

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nmap <C-t> :ProjectFiles<CR>

" Rust spec
nnoremap <leader>r :!cargo run --release \| less<CR>
nnoremap <leader>t :!cargo test \| less<CR>

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> <C-m> :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> <C-e> :call LanguageClient#explainErrorAtPoint()<CR>
" nnoremap <silent> <leader>l :call LanguageClient_textDocument_formatting()<CR>
" nnoremap <silent> <C-p> :call LanguageClient_workspace_symbol()<CR>
" nnoremap <silent> <A-cr> :call LanguageClient_textDocument_codeAction()<CR>


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

" call neomake#configure#automake('nw', 750)

set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox


"function! LspMaybeHover(is_running) abort
"  if a:is_running.result
"    call LanguageClient_textDocument_hover()
"  endif
"endfunction
"
"function! LspMaybeHighlight(is_running) abort
"  if a:is_running.result
"    call LanguageClient#textDocument_documentHighlight()
"  endif
"endfunction

"augroup lsp_aucommands
"  au!
"  au CursorHold * call LanguageClient#isAlive(function('LspMaybeHover'))
"  au CursorMoved * call LanguageClient#isAlive(function('LspMaybeHighlight'))
"augroup END
"

" Imported from coc

"" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <C-x><C-o> to complete 'word', 'emoji' and 'include' sources
imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Show signature help while editing
autocmd CursorHoldI * silent! call CocAction('showSignatureHelp')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>l  <Plug>(coc-format-selected)
nmap <leader>l  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <A-cr>  <Plug>(coc-codeaction)
nnoremap <silent> <C-p> :call LanguageClient_workspace_symbol()<CR>

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Shortcuts for denite interface
" Show symbols of current buffer
nnoremap <silent> <space>o  :<C-u>Denite coc-symbols<cr>
" Search symbols of current workspace
nnoremap <silent> <space>t  :<C-u>Denite coc-workspace<cr>
" Show diagnostics of current workspace
nnoremap <silent> <space>a  :<C-u>Denite coc-diagnostic<cr>
" Show available commands
nnoremap <silent> <space>c  :<C-u>Denite coc-command<cr>
" Show available services
nnoremap <silent> <space>s  :<C-u>Denite coc-service<cr>
" Show links of current buffer
nnoremap <silent> <space>l  :<C-u>Denite coc-link<cr>

highlight link CocErrorSign GruvboxRed
highlight link CocWarningSign GruvboxYellow


let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
