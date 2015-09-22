"TODO: create a function that, upon pressing ctrl-g, will save your position
"in the file, reindent the file, and then reposition your cursor back where
"you left it.
let mapleader=';'
set nocompatible
set mouse=a
set laststatus=2
set nowrap
set number
set backspace=indent,eol,start
set rtp+=~/.vim/bundle/Vundle.vim
set history=100
set incsearch
set ignorecase
set smartcase
set hlsearch
set background=dark
set ruler
"set backup
"set backupdir=~/.vim/backup
"set directory=~/.vim/tmp
set autochdir
set showcmd
set lazyredraw

"highlight ColorColumn ctermbg=7
" Different scheme for different time
"if (strftime("%H") >= "21" || strftime("%H") <= "06")
"make something your colorscheme
"endif

inoremap jk <ESC>
inoremap <c-d> <ESC>0d$i
inoremap wq <ESC>:wq<CR>
"Check what these do
"noremap <leader>y "*y
"noremap <leader>yy "*Y
"noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
inoremap <c-g> <esc>gg=Ggg
nnoremap <c-g> <esc>gg=Ggg
" For when you come up with a great keymapping in the heat of coding
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>q :nohlsearch<CR>
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>
nnoremap j gj
nnoremap k gk

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
                \ if expand("<afile>:p:h") !=? $TEMP |
                \   if line("'\"") > 1 && line("'\"") <= line("$") |
                \     let JumpCursorOnEdit_foo = line("'\"") |
                \     let b:doopenfold = 1 |
                \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
                \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
                \        let b:doopenfold = 2 |
                \     endif |
                \     exe JumpCursorOnEdit_foo |
                \   endif |
                \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
                \ if exists("b:doopenfold") |
                \   exe "normal zv" |
                \   if(b:doopenfold > 1) |
                \       exe  "+".1 |
                \   endif |
                \   unlet b:doopenfold |
                \ endif
augroup END

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
" Need to figure out how to make it less intrusive first
" Plugin 'scrooloose/syntastic'
"Plugin 'ryanoasis/vim-webdevicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'mattn/emmet-vim'
" TIM: enable these one by one if you like, go to their githubs
"Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'flazz/vim-colorschemes'
call vundle#end()

syntax on
filetype plugin indent on
set autoindent
colorscheme monokai
filetype plugin on
"colorscheme inkpot

" NERDtree
:nmap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Enable UTF-8 to properly display directory arrows. Otherwise, uncomment this.
"let g:NERDTreeDirArrows=0
" A function that automatically closes NERDTree if it is the last buffer open
function! NERDTreeQuit()
    redir => buffersoutput
    silent buffers
    redir END
    let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
    let windowfound = 0
    for bline in split(buffersoutput, "\n")
        let m = matchlist(bline, pattern)
        if (len(m) > 0)
            if (m[2] =~ '..a..')
                let windowfound = 1
            endif
        endif
    endfor

    if (!windowfound)
        quitall
    endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

" 256 colors
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" Tab Settings
:set expandtab tabstop=4 shiftwidth=4 softtabstop=4
:nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap <leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
au FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType eruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

let g:numbers_exclude = ['nerdtree']

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_population_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_c_auto_refresh_includes=1

" UltiSnips settings so that there's no competition with YCM
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

" airline
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#syntastic#enabled = 10
