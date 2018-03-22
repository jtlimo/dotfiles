set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bf4/vim-dark_eyes'
Plugin 'andbar-ru/vim-unicon'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
call vundle#end()
set background=dark
colorscheme unicon

map <C-n> :NERDTreeToggle<CR>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim
set nowrap        		"don't wrap lines
set shiftround    		"use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     		"set show matching parenthesis
set ignorecase    		"ignore case when searching
set smartcase     		"ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch     		"show search matches as you type

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

set hls "highlight search"
set hlsearch      		"highlight search terms


" ================ Indentation ======================
set copyindent   		"copy the previous indentation on autoindenting
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=8
set expandtab
set modeline
filetype indent plugin on

" ============ History =================

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
