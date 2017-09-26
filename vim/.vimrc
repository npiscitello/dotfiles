" Vundle stuff
filetype off                      " required to start Vundle
set rtp+=~/.vim/bundle/Vundle.vim " tell Vim to use Vundle
call vundle#begin()               " start Vundle
" We do not want Vundle to manage itself b/c it's a submodule in the dotfiles repo
" Therefore, an attempt to update will always fail b/c it's pointing at a commit, not a branch
"Plugin 'VundleVim/Vundle.vim'     " let Vundle manage itself
" Vundle plugins
Plugin 'Valloric/YouCompleteMe'             " autocompletion and syntax checking
Plugin 'sjl/gundo.vim'                      " undo tree visualizer
Plugin 'lervag/vimtex'                      " latex plugin
Plugin 'altercation/vim-colors-solarized'   " color scheme
Plugin 'jeffkreeftmeijer/vim-numbertoggle'  " intelligent relative/absolute line numbering

" Finish declaring Vundle plugins
call vundle#end()

" turns on filetype recognition
filetype plugin indent on

" prevent YCM from loading
"let g:loaded_youcompleteme = 1
" YCM - default info for syntax completion
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" YCM - shorten the time resting before background processes run
let g:ycm_allow_changing_updatetime = 1
" YCM - load syntax completion info without asking
let g:ycm_confirm_extra_conf = 0
" YCM - populate location list with errors and warnings
let g:ycm_always_populate_location_list = 1
" YCM - python3
let g:ycm_server_python_interpreter = "python3"
" don't spin up the 'Scratch' window on an autocompletion
set completeopt-=preview

" vimtex - ignore launch errors
let g:vimtex_echo_ignore_wait = 1
" vimtex - make sure to recognize '.tex' as latex
let g:tex_flavor = 'latex'

" gundo - use python3
let g:gundo_prefer_python3 = 1

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
set cursorline                        " enable highlighting the current line
syntax enable				                  " enables syntax highlighting
set shell=bash\ --login               " spawn the subshell as a login shell

" enable solarized - uncomment next line to use 256 color mode
" let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" highlighting settings
"hi CursorLine cterm=none ctermbg=16               " set highlighting color for current line highlighting
hi Search cterm=none ctermbg=226 ctermfg=16       " highlight search matches in yellow
hi Pmenu cterm=none ctermfg=7 ctermbg=16          " highlight YCM completion window subshell
"hi Folded ctermbg=13 ctermfg=7                    " set color for folded indicator (for diff)
"hi! link FoldColumn Folded                        " make foldedcolumn copy folded (for diff)
hi SignColumn ctermbg=8                           " set the empty gutter color
hi YcmWarningSign ctermbg=3 ctermfg=7             " highlight YCM syntax warnings
hi! link YcmWarningSection YcmWarningSign         " highlight YCM syntax warnings
hi YcmErrorSign ctermbg=1 ctermfg=7               " highlight YCM syntax errors
hi! link YcmErrorSection YcmErrorSign             " highlight YCM syntax errors
"hi DiffAdd cterm=none ctermbg=2 ctermfg=7         " highlight vimdiff added lines
"hi DiffDelete cterm=none ctermbg=1 ctermfg=7      " highlight vimdiff deleted lines
"hi DiffChange cterm=none ctermbg=4 ctermfg=7      " highlight vimdiff changed lines
"hi DiffText cterm=bold ctermbg=7 ctermfg=4        " highlight vimdiff changed text (just reversed change highlighting)
hi VertSplit cterm=bold ctermbg=0 ctermfg=7       " make the vertical separator less intrusive
hi StatusLine cterm=bold ctermbg=0 ctermfg=7      " make the status line less intrusive
hi StatusLineNC cterm=none ctermbg=0 ctermfg=10   " make the inactive status lines less intrusive

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
set statusline=%-f\ %-y\ %-m%=L%l\ C%c\ %p%%
"   0: never show status line
"   1: only show status line with 2+ files open
"   2: always show status line
set laststatus=2

" Make tabs actual tabs in Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" start compile in latex docs
autocmd FileType tex VimtexCompile

" key remapping
let mapleader=" "	" replace '\' as leader
let maplocalleader=" " " replace local leader
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
" remap capital j and k to paragraph movement
" (commented below are half and full page movement mappings)
nnoremap K {
vnoremap K {
nnoremap J }
vnoremap J }
"nnoremap K <C-u>
"nnoremap J <C-d>
"nnoremap K <C-b>
"nnoremap J <C-f>
" remap capital b and w to beginning/end of line in normal and visual mode
nnoremap B 0
vnoremap B 0
nnoremap W $
vnoremap W $

" leader aliases
" clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" move a line up or down
noremap <leader>k ddkkp
noremap <leader>j ddp
" quickly open and source the .vimrc file
nnoremap <leader>ev :vs $MYVIMRC<CR>
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
" re-compile for YCM errors
nnoremap <leader>yr :YcmForceCompileAndDiagnostics<CR>
" trigger YCM FixIt
nnoremap <leader>fx :YcmCompleter FixIt<CR>
" Open YCM diagnostics quickly
nnoremap <leader>yd :YcmDiags<CR>
" jump to next/previous location
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
