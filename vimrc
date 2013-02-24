" Use Vim settings
set nocompatible

" Load pathogen
call pathogen#infect()
call pathogen#helptags()

" Turn on syntax highlighting
syntax on

" Deal with hidden buffers normally
set hidden

" General configuration
set number
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set autoread
set ruler
set cmdheight=2
set magic
set incsearch
set hlsearch
set textwidth=78
let &wrapmargin= &textwidth

" Status bar
set laststatus=2
set rtp+=$HOME/Library/Python2.7/lib/python/site-packages/powerline/bindings/vim

" Alerts
set visualbell
set noerrorbells

" Files, backups, swapfiles
set nobackup
set nowb
set noswapfile

" Spacing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Indentation
set autoindent
set smartindent

filetype plugin on
filetype indent on

set nowrap
set linebreak

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*DS_Store
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" font
set guifont=Inconsolata\ for\ Powerline:h16

" color bar
hi ColorColumn guibg=#363946

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:
nnoremap <silent><F5> :DeleteTrailingWhitespace<CR>

" ColorColumn
function! ToggleColorColumn()
  if &colorcolumn == 0
    " Draw the color column wherever wrapmargin is set
    let &colorcolumn = &wrapmargin
  else
    let &colorcolumn = 0
  endif
endfunction
command! ToggleColorColumn call ToggleColorColumn()
map _c : call ToggleColorColumn()<CR>

" autoload changes to the vimrc
if ("autocmd")
    autocmd bufwritepost ~/.vimrc source $MYVIMRC
endif

" quick-toggle list mode
nmap <leader>l :set list!<CR>

" Tags tagbar toggle
nmap <F8> :TagbarToggle<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
