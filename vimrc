" No backwards compatibility to VI
set nocompatible

" ------------------ Plugins


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Own Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kchmck/vim-coffee-script'

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " Always show the status bar
set t_Co=256     " Colors

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/cpp/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/uni/pt-2/.ycm_extra_conf.py', '~/uni/semester-1/pt-1/.ycm_extra_conf.py', '~/uni/cp/.ycm_extra_conf.py']

" Solarized Color Scheme
syntax enable
set background=dark

" Syntastic Settings
set statusline +=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_pylint_exe = "pylint3"
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_cpp_include_dirs = [ '/home/richard/Qt5.9.2/5.9.2/gcc_64/include/QtWidgets/']

call vundle#end()


"------------------- pandoc Markdown+LaTeX
function s:MDSettings()
    inoremap <buffer> <Leader>n \note[item]{}<Esc>i
    noremap <buffer> <Leader>b :! pandoc -t beamer % -o %<.pdf<CR><CR>
    noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
    noremap <buffer> <Leader>v :! evince %<.pdf 2>&1 >/dev/null &<CR><CR>

    " adjust syntax highlighting for LaTeX parts
    "   inline formulas:
    syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"
    "   environments:
    syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement
    "   commands:
    syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
    syntax region Statement matchgroup=Delimiter start="$$" end="$$" contains=Statement
endfunction

autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd FileType markdown :call <SID>MDSettings()


" ------------------ Settings


colorscheme solarized

filetype plugin indent on

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python let &colorcolumn="80,".join(range(100,999),",")
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

" Whitespace Rendering
set listchars=tab:▸\ ,trail:·
set list

" Behaviour
set clipboard=unnamed   " share OS clipboard
set autoread            " skip file reload question
set number              " show line number instead of 0
set relativenumber      " relative line numbers
set ttyfast             " faster redrawing
set scrolloff=3         " always 3 lines visible

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

" Go to next / previous marked location:
nnoremap <leader>n :lnext<cr>
nnoremap <leader>p :lprevious<cr>

" Go to definition:
nnoremap <leader>g :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>G :YcmCompleter GoToDefinition<CR>

" Toggle Comment on current line
" Based on tpope's commentary plugin
nnoremap <leader>c :Commentary<cr>

" Quick Buffer Switching
nnoremap <leader><leader> <C-^>

" Clear match highlighting

noremap <leader><space> :noh<cr>:call clearmatches()<cr>

inoremap jf <esc>
inoremap Jf <esc>
inoremap JF <esc>

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
