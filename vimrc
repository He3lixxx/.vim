" No backwards compatibility to VI
set nocompatible

" ------------------ Plugins

" Vundle Setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Own Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'hdima/python-syntax'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'


" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " Always show the status bar
set t_Co=256     " Colors

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1

" Solarized Color Scheme
let g:solarized_termcolors=16
syntax enable
set background=dark


call vundle#end()

" ------------------ Settings

colorscheme solarized

filetype plugin indent on

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

" Indentation
set tabstop=4           " 1 tab = 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab           " to spaces
set smarttab            " treat spaces as tabs
set shiftround
set autoindent
set smartindent

" Whitespace Rendering
set listchars=tab:▸\ ,trail:·
set list

" Behaviour
set clipboard=unnamed   " share OS clipboard
set autoread            " skip file reload question
set number              " show line number instead of 0
set relativenumber      " relative line numbers
set ttyfast             " faster redrawing

set mouse+=a            " allow mouse usage for resizing windows
if &term =~ '^screen'
    set ttymouse=xterm2
endif

set hidden              " allow hidden, unsaved buffers
set showmatch           " hilight matching surroundings

" Search Options
set ignorecase          " case-insensitive searching for lower-case expressions
set smartcase           " case-sensitive searching for mixed-case expressions
set incsearch           " search while typing
set hlsearch            " hilight search results
set gdefault            " substitute all matches by default

" Own keybindings
let mapleader = ","

" Go to definition:
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Toggle Comment on current line
nnoremap <leader>c <Plug>CommentaryLine

" Quick Buffer Switching
nnoremap <leader><leader> <C-^>

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

inoremap jf <esc>

" Use sane regex's when searching
nnoremap / /\v
vnoremap / /\v

" German Mappings
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

" Visual line nav, not real line nav
" For navigatin into wrapped lines
noremap j gj
noremap k gk

