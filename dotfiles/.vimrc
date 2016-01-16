set nocompatible

filetype off

syntax on

colorscheme solarized

" Colors let me know whether I'm in a VM
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set background=dark
    " Do Mac stuff here
  else
    set background=light
  endif
endif

let g:solarized_termcolors = 256
set nu
set ignorecase
set smartcase
set incsearch
set hlsearch
set expandtab
autocmd Filetype javascript,sh,vim setlocal shiftwidth=2 tabstop=2
autocmd Filetype python setlocal shiftwidth=4 tabstop=4
autocmd Filetype html setlocal shiftwidth=2 tabstop=2
autocmd Filetype markdown setlocal shiftwidth=2 tabstop=2
set autoindent

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" NERDTree 
Plugin 'scrooloose/nerdtree'

" SuperTab
Plugin 'ervandew/supertab'

" Syntastic
Plugin 'scrooloose/syntastic'

" surround.vim
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

" fugitive.vim
" http://vimawesome.com/plugin/fugitive-vim
" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

" status line
Plugin 'bling/vim-airline'

" javascript syntax highlighting
Plugin 'pangloss/vim-javascript'

" Fuzzy file finder
Plugin 'kien/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree
" CTRL+n opens up NERTDTREE
map <C-n> :NERDTreeToggle<CR>
" Automatically open NERDTree when vim starts up:
" autocmd vimenter * NERDTree

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType javascript       let b:comment_leader = '// '
autocmd FileType yaml,sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType html             let b:comment_leader = '<!-- '

" Close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" timeout
set timeout timeoutlen=1000
" map jj to escape key
imap <silent> jj <Esc>
" instead of map to ctrlp!
nmap <silent> <Bslash> :CtrlP<CR>

" fold everything by indentation
set foldmethod=indent

" clipboard!
set clipboard=unnamed

" Syntastic options for linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']


" ######## CTRLP SETTINGS
" ignore meh files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/external/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$'
  \ }



" ######## AIRLINE SETTINGS

" Show statusline
set laststatus=2
" Show full path
set statusline+=%F
" Set statusline color based on mode
if version >= 700
    au InsertEnter * hi StatusLine term=reverse ctermbg=Green gui=undercurl guibg=Green
    au InsertLeave * hi StatusLine term=reverse ctermbg=DarkMagenta gui=bold,reverse
endif
" Default the statusline to green when entering Vim
hi StatusLine guibg=Green ctermbg=Green
" Airline settings
let g:airline_theme = 'solarized'
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


