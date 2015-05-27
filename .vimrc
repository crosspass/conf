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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-bundler'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" colorscheme soloarized
Plugin 'altercation/vim-colors-solarized'

" Ctrlp path plugin
Plugin 'kien/ctrlp.vim'

" status bar
Plugin 'bling/vim-airline'

" golang plugin
" Plugin 'fatih/vim-go'

" ruby plugin
Plugin 'ngmy/vim-rubocop'
Plugin 'sunaku/vim-ruby-minitest'

" preview tools
Plugin 'majutsushi/tagbar'

" search tools
Plugin 'rking/ag.vim'

" visual search *,#
Plugin 'nelstrom/vim-visual-star-search'

" Qarg
Plugin 'nelstrom/vim-qargs'

" vim-slim
Plugin 'slim-template/vim-slim'

" This project adds CoffeeScript support to vim. It covers syntax, indenting, compiling, and more.
Plugin 'kchmck/vim-coffee-script'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"...Install Plugins...
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end


" vim
filetype plugin indent on    " required
syntax enable
let mapleader = ','
runtime= 'macros/matchit.vim'
set hidden
set modified
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
" set incsearch
set is

" set colorscheme
set background=dark
colorscheme solarized

" more than 80 characters highlight
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" tail space highlight
highlight ExtraWhitespace ctermbg=red guibg=red

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

autocmd BufWinEnter * 2match OverLength  /\%81v.\+$/
" autocmd InsertEnter * match OverLength /\%81v.\+\%#\@<!$/
autocmd InsertLeave * 2match OverLength /\%81v.\+$/

" easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"isert debug statement
nmap <c-d> <Esc>orequire 'pry'<CR>binding.pry<Esc>

"autoload .vimrc when it changed
augroup reload_vimrc "{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END "}


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

" configure vim-rubocop
au FileType ruby nmap <Leader>ru<Plug>(rubo-cop)


" ruby pry isert debug statement
nmap <c-d> <Esc>orequire 'pry'<CR>binding.pry<Esc>

" insert #encoding: utf-8 at header of text
nmap ,e <Esc>maggO#encoding: utf-8<Esc>o<Esc>'a
" delete tail blank   
nmap ,d <Esc>:%s/\s\+$//g<CR>


" configure ag
let g:ackgrp='ag -vimgrep'
