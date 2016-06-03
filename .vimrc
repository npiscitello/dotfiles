" Vundle stuff
filetype off                      " required to start Vundle
set rtp+=~/.vim/bundle/Vundle.vim " tell Vim to use Vundle
call vundle#begin()               " start Vundle
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself

" Vundle plugins
Plugin 'Valloric/YouCompleteMe'           " autocompletion and syntax checking
Plugin 'sjl/gundo.vim'                    " undo tree visualizer
Plugin 'altercation/vim-colors-solarized' " color scheme
Plugin 'jelera/vim-javascript-syntax'     " syntax highlighting

" Finish declaring Vundle plugins
call vundle#end()

" turns on filetype recognition
filetype plugin indent on

" misc. settings
set nocompatible                " be iMproved
set number					            " turn on line numbers
set numberwidth=4		            " sets width of number colum (allows up to 999 with no movement)
set autoindent                  " enable autoindenting
set shiftround			            " rounds auto indents to multiples of shiftwidth spaces
set showmatch				            " shows matching parens, etc.
set matchtime=0			            " time delay to start matching paren
set shiftwidth=5		            " specifies the auto indent width
set nowrap					            " disables line wrapping
set incsearch				            " show search results realtime
set hlsearch				            " highlight search matches
set ts=2 sw=2 sts=2	            " set tabs to be 2 spaces
set expandtab				            " tabs expand as spaces
set splitbelow                  " sp opens window below current window
set splitright                  " vsp opens window to the right of current window
syntax enable				            " enables syntax highlighting
set background=dark             " use a dark theme
colorscheme solarized           " choose a base16 colorscheme

" setup statusline:
"   %-f: left justified relative file path
"   %-y: left justified recognized file type
"   %-m: modified status (not present, [+], or [-] for ro file)
"   %=: left justified / right justified content split
"   %l: line number
"   %c: column number
"   %p: percentage through file by line
"   %%: escaped percent symbol
"   \ : escaped space
set statusline=%-f\ %-y\ %-m%=%l\ %c\ %p%%
"   0: never show status line
"   1: only show status line with 2+ files open
"   2: always show status line
set laststatus=2

" Make tabs actual tabs in Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" key remapping
let mapleader=" "	" replace '\' as leader
" clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" move by visual lines, not actual lines
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
" change windows with Ctl and nav keys
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" remap escape
inoremap jk <esc>
" remap keys around i
nnoremap u <NOP>
nnoremap o <NOP>
" save file
nnoremap <leader>ww :w<CR>
" save and spawn a subshell
nnoremap <leader>sh :wa<CR>:sh<CR>
" save and exit
nnoremap <leader>wq :w<CR>:q<CR>

" Abbreviations
iabbrev @@ nb.piscitello@gmail.com
