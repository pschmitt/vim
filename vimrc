"set runtimepath=~/.vim,$VIMRUNTIME,~/.vim/after
" Basics
syntax on " enable syntax highlighting
set showmatch " show matching brackets (),{},[]
set number
set nocompatible
" set background=black
set encoding=utf-8
filetype on

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set t_Co=256
set mouse=a
set termencoding=utf-8

set backspace=indent,eol,start

" Indenting, Folding..
set tabstop=4 " numbers of spaces of tab character
set shiftwidth=4 " numbers of spaces to (auto)indent
set expandtab " insert spaces instead of tab chars
set autoindent   " always set autoindenting on
set cindent   " cindent
set foldenable
set foldmethod=marker
set hlsearch " highlight all search results

set laststatus=2 " occasions to show status line, 2=always.
set cmdheight=1 " command line height
" set ruler " ruler display in status line
" set showmode " show mode at bottom of screen
" set previewheight=5

" Set taglist plugin options
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Inc_Winwidth = 1

" key bindings
" change leader, defaults to \
let mapleader = ","

" Toggle taglist script
map <F2> :TlistToggle<CR>

map <F3> :NERDTreeToggle<cr>

" Toggle highlight current line and col
map <F4> :set cursorcolumn! cursorline! <CR>

" Toggle relative line numbering
map <F6> :call ToggleRelativeNumber()<CR>
function! ToggleRelativeNumber()
    if( &nu == 1 )
        set nonu
        set rnu
    else
        set nu
        set nornu
    endif
endfunction

" Remove trailing whitespaces
map <F7>  :%s/ \+$//<CR>

" Spellcheck
map <F8> :w!<CR>:!aspell -c %<CR>:e! %<CR>
map <F9> :w!<CR>:!aspell -l fr_FR -c %<CR>:e! %<CR>

" common save shortcuts
" inoremap <C-s> <esc>:w<cr>a
" nnoremap <C-s> :w<cr>

" Set bracket matching and comment formats
set matchpairs+=<:>
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*
set comments+=b:\"
set comments+=n::

" Fix filetype detection
au BufNewFile,BufRead .torsmorc* set filetype=rc
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.sys set filetype=php
au BufNewFile,BufRead grub.conf set filetype=grub
au BufNewFile,BufRead *.dentry set filetype=dentry
au BufNewFile,BufRead *.blog set filetype=blog

" C file specific options
au FileType c,cpp set cindent
au FileType c,cpp set formatoptions+=ro

" HTML abbreviations
au FileType html,xhtml,php,eruby imap bbb <br /><return>
au FileType html,xhtml,php,eruby imap aaa <a href=""><return><return></a><up><up><right><right><right><right><right>
au FileType html,xhtml,php,eruby imap iii <img src="" /><return><return></img><up><up><right><right><right><right>
au FileType html,xhtml,php,eruby imap ddd <div class=""><return><return></div>
au FileType html,xhtml,php,eruby imap lll <li><return><return></li><up><tab><tab>
" Session Settings
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
map <c-q> :mksession! ~/.vim/.session <cr>
map <c-s> :source ~/.vim/.session <cr>

" Set up the status line
fun! <SID>SetStatusLine()
    let l:s1="%-3.3n\\ %f\\ %h%m%r%w"
    let l:s2="[%{strlen(&filetype)?&filetype:'?'},%{&encoding},%{&fileformat}]"
    let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
    execute "set statusline=" . l:s1 . l:s2 . l:s3
endfun
set laststatus=2
call <SID>SetStatusLine()

" Turn off blinking
set novb
" Turn off beep
"set noerrorbells
"set t_vb=

" highlight redundant whitespaces and tabs.
"autocmd ColorScheme * highlight RedundantSpaces ctermbg=red guibg=red
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t\%#\@<!/

" Mutt integration
autocmd BufRead ~/.mutt/temp/mutt*   :source ~/.vim/mail.vimrc

" theme
"colors Mustang_Vim_Colorscheme_by_hcalves
color Vitamins_Vim_Colorscheme_by_hcalves

" restore cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
