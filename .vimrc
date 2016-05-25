" Vundle stuff
filetype off                      " required to start Vundle
set rtp+=~/.vim/bundle/Vundle.vim " tell Vim to use Vundle
call vundle#begin()               " start Vundle
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself

" Vundle plugins
Plugin 'Valloric/YouCompleteMe'           " autocompletion and syntax checking
Plugin 'sjl/gundo.vim'                    " undo tree visualizer
Plugin 'altercation/vim-colors-solarized' " color scheme

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
" remap excape
inoremap jk <esc>

" Abbreviations
iabbrev @@ nb.piscitello@gmail.com
