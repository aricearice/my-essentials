set nocompatible

filetype off


syntax on
colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif
let g:solarized_termcolors = 256
set nu
set ignorecase
set smartcase
set incsearch
set hlsearch
set expandtab
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2
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

" vim-autoformat
" https://github.com/Chiel92/vim-autoformat
" Plugin 'Chiel92/vim-autoformat'

" surround.vim
" https://github.com/tpope/vim-surround
" Plugin 'tpope/vim-surround'

" vim-go
" https://github.com/fatih/vim-go
" go syntax + auto complete
" Plugin 'fatih/vim-go'

" fugitive.vim
" http://vimawesome.com/plugin/fugitive-vim
" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

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
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType html             let b:comment_leader = '<!-- '

" Close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>