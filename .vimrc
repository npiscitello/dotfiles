" misc. settings
set number					" turn on line numbers
set numberwidth=4		" sets width of number colum (allows up to 999 with no movement)
set shiftround			" rounds auto indents to multiples of shiftwidth spaces
set showmatch				" shows matching parens, etc.
set matchtime=0			" time delay to start matching paren
set shiftwidth=5		" specifies the auto indent width
set nowrap					" disables line wrapping
set incsearch				" show search results realtime
set hlsearch				" highlight search matches
set ts=2 sw=2 sts=2	" set tabs to be 2 spaces
set expandtab				" tabs expand as spaces
set splitbelow      " sp opens window below current window
set splitright      " vsp opens window to the right of current window
syntax enable				" enables syntax highlighting
color zellner				" change the color scheme

" Enable pathogen. Current plugins:
"	- Gundo: simple undo tree viewer
" - vim-stylus: stulus syntax highlighting
" - vim-pug: pug (formerly Jade) syntax highlighting
" - vim-syntastic: syntax checking
" - vim-javascript-syntax: enhanced javascript syntax highlighting
execute pathogen#infect()

" syntastic recommended defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" use google js checker for syntastic
let g:syntastic_javascript_closurecompiler_path = "~/.vim/syntastic_checkers/closurecompiler.jar"
let g:syntastic_javascript_checkers = ["closurecompiler"]

" key remapping
let mapleader=" "	" replace '\' as leader
" clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" <Up> anid <Down> move by visual lines, not actual lines
noremap k gk
noremap j gj
" show Gundo undo tree visualization
noremap <c-z> :GundoToggle<CR>
" move a line up or down
noremap <leader>k ddkkp
noremap <leader>j ddp
" quickly open and source the .vimrc file
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" break arrow key habit!
noremap! <Up> <NOP>
noremap! <Down> <NOP>
noremap! <Left> <NOP>
noremap! <Right> <NOP>
" change windows with Ctl and nav keys
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" remap excape and break old habit
inoremap jk <esc>
vnoremap jk <esc>

" Abbreviations
iabbrev @@ nb.piscitello@gmail.com
