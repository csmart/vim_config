" Vim needs a POSIX shell
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" Navigation
Plugin 'scrooloose/nerdtree' "File system explorer for the Vim editor
Plugin 'ctrlpvim/ctrlp.vim' "Fuzzy file, buffer, mru, tag, etc finder
Plugin 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits

" Language related
Plugin 'klen/python-mode' "Helps you to create python code very quickly
Plugin 'davidhalter/jedi-vim' "Python autocompletion with VIM
Plugin 'majutsushi/tagbar' "Displays tags in a window, ordered by scope
Plugin 'mzlogin/vim-markdown-toc' "Generate markdown TOC
Plugin 'avakhov/vim-yaml' "Dumb-smart indentation for Yaml
" If file type not detected:
" :set ft=ansible
" Or set something like this in ~/.vimrc.local
" au BufRead,BufNewFile */playbooks/*.yml set filetype=ansible
Plugin 'pearofducks/ansible-vim' "Syntax highlighting Ansible's common filetypes
Plugin 'vim-syntastic/syntastic' " Syntax checking hacks for vim

" Beautify Vim
Plugin 'altercation/vim-colors-solarized' "Precision colorscheme for the vim text editor
Plugin 'vim-airline/vim-airline' "Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline-themes' "Themes for airline

" Git related
Plugin 'tpope/vim-fugitive' "The best Git wrapper of all time
Plugin 'airblade/vim-gitgutter' "shows a git diff in the gutter (sign column)
Plugin 'Xuyuanp/nerdtree-git-plugin' "NERDTree showing git status flags

" Load any custom vundles
silent! source ~/.vimrc.local.vundles

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" The rest of your config follows here

syntax enable
set incsearch
set hlsearch
set sw=4
set ts=4
set expandtab
set textwidth=79

" Set cursor crosshairs (column, line)
"set cuc
set cul

" Hide buffers instead of closing them
set hidden

" Set list to show white space
set list
set listchars=tab:»·,trail:§,extends:¬,precedes:«,nbsp:§

" If your running OSX and backspace doesn't behave correctly uncomment this
" following line
"set backspace=indent,eol,start

" Font Hack as the default font
set guifont=Hack\ 9
set laststatus=2
"
" Set solarized colour scheme

" (optional) If everything is too bright and high contrast, then uncomment
" the next 2 lines:
" loading the solarized colorscheme is silent to prevent error during initial install
silent! colorscheme solarized
"set term=screen-256color
"let g:solarized_termcolors=256
set background=dark

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
    augroup END

" Tagbar setup
" NOTE: you need ctags installed, so will keep this commented out for now
"nmap <F9> :TagbarToggle<CR>
" (Optional) If you are on OSX or have ctags (non-BSD) installed somewhere else not in
" your path, use to following line to point to it.
"let g:tagbar_ctags_bin="/usr/local/Cellar/ctags/5.8_1/bin/ctags"

" Nerdtree setup
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline Setup
"  smarter tab line
"let g:airline#extensions#tabline#enabled = 1
"
"  Separators can be configured independently for the tabline
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
" Automatically fix PEP8 errors in the current buffer:
noremap <F8> :PymodeLintAuto<CR>

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Finally, load any overrides from the local box
" (silent in case it doesn't exist)
" The old location for the file
silent! source ~/.vimrc_overrides
" New location
silent! source ~/.vimrc.local

