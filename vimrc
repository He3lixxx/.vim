" No backwards compatibility to VI
set nocompatible
scriptencoding utf-8
set encoding=utf-8
" ------------------ Plugins
filetype off
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
Plugin 'tpope/vim-sleuth'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lifepillar/vim-solarized8'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'w0rp/ale'

call vundle#end()
syntax enable
filetype plugin indent on

" Security - can be removed if vim is updated here
" https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-12735.html
set nomodeline

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " Always show the status bar
set t_Co=256     " Colors

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/cpp/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = [
      \ '~/uni/pt-2/.ycm_extra_conf.py',
      \ '~/uni/semester-1/pt-1/.ycm_extra_conf.py',
      \ '~/uni/cp/.ycm_extra_conf.py',
      \ '~/uni/dyod/.ycm_extra_conf.py',
      \ ]


" Solarized Color Scheme
set termguicolors
set background=dark
colorscheme solarized8

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\}


" Workaround for closing location list when a buffer is deleted (:bd)
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

" FZF
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"------------------- pandoc Markdown+LaTeX
function s:MDSettings()
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
function! CElseL(command)
  try
    if len(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist'))
      execute "c" . a:command
      return
    endif

    execute "l" . a:command
  catch /./
    echo v:exception
  endtry
endfunction

" Indentation
set tabstop=4           " 1 tab = 4 spaces
set shiftround
set autoindent

" should be set by vim-sleuth - these are just defaults for new files
set shiftwidth=4
set expandtab           " to spaces
set softtabstop=4
set smarttab            " treat spaces as tabs

" Whitespace Rendering
set listchars=tab:▸\ ,trail:·
set list

" Show 80th, 100th and 120th column
let &colorcolumn="80,100,120"

" Don't wrap by default
set nowrap

" Behaviour
set clipboard=unnamed   " share OS clipboard
set autoread            " skip file reload question
set number              " show line number instead of 0
set relativenumber      " relative line numbers
set ttyfast             " faster redrawing
set scrolloff=3         " always 3 lines visible
set nostartofline       " do not go to start of line when changing buffers


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

" Ripgrep as grep engine
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" open location list after :grep
augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END

" Own keybindings
let mapleader = ","

" start global search for word under cursor with <leader>f
nnoremap <leader>f :Rg <c-r>=expand("<cword>")<cr>
nnoremap <leader>F :Rg <c-r>=expand("<cWORD>")<cr>

" Go to next / previous marked location:
nnoremap <silent><leader>n :call CElseL("next")<cr>
nnoremap <silent><leader>p :call CElseL("previous")<cr>

" Go to definition:
nnoremap <leader>g :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>G :YcmCompleter GoToDefinition<CR>

" Quick Buffer Switching
nnoremap <leader><leader> <C-^>

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Escape alternatives
inoremap jf <esc>
inoremap Jf <esc>
inoremap JF <esc>

" Use sane regex's when searching
nnoremap / /\v
vnoremap / /\v

" German Mappings
map ß /

" Visual line nav, not real line nav
" For navigatin into wrapped lines
noremap j gj
noremap k gk
