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


" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " Always show the status bar
set t_Co=256     " Colors


call vundle#end()

" ------------------ Settings

filetype plugin indent on

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
augroup END

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab      " to spaces
set smarttab       " treat spaces as tabs
set shiftround
set autoindent
set smartindent

" Whitespace Rendering
set listchars=tab:▸\ ,trail:·
set list

" Behaviour
set clipboard=unnamed " share OS clipboard
set autoread          " skip file reload question
set number
set relativenumber

" Search Options
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

" Own keybindings
let mapleader = ","

inoremap jf <esc>

" Toggle Comment on current line
nnoremap <leader>c <Plug>CommentaryLine

" Quick Buffer Switching
nnoremap <leader><leader> <C-^>

" create new vsplit, and switch to it.
noremap <leader>v <C-w>v

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" bindings for easy split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

