" Vundle stuff
filetype off                      " required to start Vundle
set rtp+=~/.vim/bundle/Vundle.vim " tell Vim to use Vundle
call vundle#begin()               " start Vundle
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself

" Vundle plugins
Plugin 'Valloric/YouCompleteMe'           " autocompletion and syntax checking
Plugin 'sjl/gundo.vim'                    " undo tree visualizer

" Finish declaring Vundle plugins
call vundle#end()

" turns on filetype recognition
filetype plugin indent on

" setup YCM
let g:ycm_server_python_interpreter="/usr/bin/python2"

" misc. settings
set nocompatible                      " be iMproved
set number					                  " turn on line numbers
set numberwidth=4		                  " sets width of number colum (allows up to 999 with no movement)
set autoindent                        " enable autoindenting
set shiftwidth=5		                  " specifies the auto indent width
set shiftround			                  " rounds auto indents to multiples of shiftwidth spaces
set showmatch				                  " shows matching parens, etc.
set matchtime=0			                  " time delay to start matching paren
set nowrap					                  " disables line wrapping
set incsearch				                  " show search results realtime
set hlsearch				                  " highlight search matches
set ts=2 sw=2 sts=2	                  " set tabs to be 2 spaces
set expandtab				                  " tabs expand as spaces
set textwidth=100                     " wrap lines to a reasonable width
set splitbelow                        " sp opens window below current window
set splitright                        " vsp opens window to the right of current window
set ignorecase									      " needed to use smartcase
set smartcase										      " use case-insensitive search unless a capital letter is typed
syntax enable				                  " enables syntax highlighting
set cursorline                        " enable highlighting the current line
hi CursorLine cterm=NONE ctermbg=16   "set highlighting color for current line highlighting

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
" move by visual lines, not actual lines
noremap k gk
noremap j gj
" show Gundo undo tree visualization
noremap <c-z> :GundoToggle<CR>
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
" disable increment/decrement numbers
nnoremap <C-A> <NOP>
nnoremap <C-X> <NOP>

" leader aliases
" clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" move a line up or down
noremap <leader>k ddkkp
noremap <leader>j ddp
" quickly open and source the .vimrc file
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" save file
nnoremap <leader>ww :w<CR>
" save and spawn a subshell
nnoremap <leader>sh :wa<CR>:sh<CR>
" save and exit
nnoremap <leader>wq :x<CR>
" exit without saving
nnoremap <leader>qq :q<CR>
" really exit without saving
nnoremap <leader>quit :q!<CR>
" start a vertical split
nnoremap <leader>vs :vs 
" start a horizontal split
nnoremap <leader>sp :sp 
" start a search and replace
nnoremap <leader>ss :%s/

" Abbreviations
iabbrev @@ nb.piscitello@gmail.com
