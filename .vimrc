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

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" colorscheme soloarized
Plugin 'altercation/vim-colors-solarized'

" Ctrlp path plugin
Plugin 'kien/ctrlp.vim'

Plugin 'jlanzarotta/bufexplorer'

Plugin 'bling/vim-airline'

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

colorscheme solarized
" set ctrlP
set runtimepath^=~/vimfiles/bundle/ctrlp.vim
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
let g:ctrlp_custom_ignore={
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dell)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }
let g:ctrlp_user_command='dir %s /-n /b /s /a-d'
" multiple VCS listing commands
let g:crlp_user_command = {
  \ 'types': {
     \ 1: ['.git', 'cd %s && git ls-files'],
     \ 2: ['.hg', 'hg -cwd %s locate -I .'],
     \ },
  \ 'fallback': 'find %s -type f'
\ }    
" set working directory
" set number line
set nu
" set encoding
set encoding=utf-8
set fileencoding=utf-8


" Search for selected text.
" http://vim.wikia.com/wiki/VimTip171
let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif
function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction
vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *
nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo

" set tab to 4 blank
set ts=2
set shiftwidth=2
set expandtab
set autoindent
" fmt go file
":autocmd VimLeave *.go !go fmt
autocmd FileType go autocmd BufWritePre <buffer> Fmt

set laststatus=2
" more than 80 characters highlight
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"isert debug statement
nmap <c-d> <Esc>orequire 'pry'<CR>binding.pry<Esc>

"autoload .vimrc when it changed
augroup reload_vimrc "{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END "}

let g:ackgrp='ag -vimgrep'
