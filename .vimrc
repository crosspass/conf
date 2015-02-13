set nocompatible 
filetype off
" set the runtime path to include Vundle and initialize
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/

call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" git plugin
Plugin 'tpope/vim-fugitive'

" commentary
Plugin 'tpope/vim-commentary'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" colorscheme soloarized
Plugin 'altercation/vim-colors-solarized'

" Ctrlp path plugin
Plugin 'kien/ctrlp.vim'

" status bar
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'

" golang plugin
Plugin 'fatih/vim-go'

" preview tools
Plugin 'majutsushi/tagbar'

" search tools
Plugin 'rking/ag.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"...Install Plugins...
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" vim
syntax enable
set background=dark
let mapleader = ','
" set encoding
set encoding=utf-8
set fileencoding=utf-8
" set tab to 4 blank
set ts=2
set shiftwidth=2
set expandtab
set autoindent
" display status bar
set laststatus=2
" menu display wild content
set wildmenu
" set search hightlight
set hls
" set colorscheme
colorscheme solarized

" set ctrlP
" multiple VCS listing commands
let g:crlp_user_command = {
  \ 'types': {
     \ 1: ['.git', 'cd %s && git ls-files'],
     \ 2: ['.hg', 'hg -cwd %s locate -I .'],
     \ },
  \ 'fallback': 'find %s -type f'
\ }    
" set working directory
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_lazy_update = 1
map ,m :CtrlPMRU<cr>
map ,l :CtrlPLastMode<cr>
" finish ctrlP configurate

" set vim-airline
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10

let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#ctrlp#color_template = 'replace'
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
" finish airline configure

" configure vim-go
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_fmt_command = "goimports"
" finish vim-go configure

" more than 80 characters highlight
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" ruby pry isert debug statement
nmap <c-d> <Esc>orequire 'pry'<CR>binding.pry<Esc>

"autoload .vimrc when it changed
augroup reload_vimrc "{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END "}

" configure ag
let g:ackgrp='ag -vimgrep'
