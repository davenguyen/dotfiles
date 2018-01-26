set nocompatible        " Better safe than sorry

call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'   " Inline git diff
  Plug 'idanarye/vim-merginal'    " git branching goodness
  Plug 'junegunn/fzf', { 'dir': '~/.dotfiles/.vim/plugin/fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'  " Text alignment
  Plug 'scrooloose/nerdtree'      " Better file explorer
  "  Plug 'scrooloose/syntastic'     " Syntax checker
  Plug 'tmm1/ripper-tags'         " Improved Ruby ctags generator
  "Plug 'tpope/vim-bundler'        " Bundler goodness
  "Plug 'tpope/vim-endwise'        " Auto close methods
  Plug 'tpope/vim-fugitive'       " git goodness
  "Plug 'tpope/vim-haml'           " Haml goodness
  "Plug 'tpope/vim-markdown'       " Markdown goodness
  Plug 'tpope/vim-rails'          " Rails goodness
  "Plug 'tpope/vim-vinegar'        " Improve netrw
  Plug 'vim-airline/vim-airline'  " Statusline improvement
  Plug 'vim-ruby/vim-ruby'        " Ruby goodness
call plug#end()

let mapleader=","
:imap kj <Esc>

set wildmenu
set wildmode=longest:full,full
set nu                       " Display line numbers
set history=1000             " Lots of history
set clipboard=unnamed        " use same clipboard as system
"set tw=80                    " Lines end at 80 characters

" delete trailing white space
au BufWritePre *.coffee :%s/\s\+$//e
au BufWritePre *.css :%s/\s\+$//e
au BufWritePre *.haml :%s/\s\+$//e
au BufWritePre *.html :%s/\s\+$//e
au BufWritePre *.js :%s/\s\+$//e
au BufWritePre *.rb :%s/\s\+$//e
au BufWritePre *.scss :%s/\s\+$//e
au BufWritePre *.vimrc :%s/\s\+$//e

" Change location of .viminfo
set viminfo+=n~/.vim/tmp/viminfo

" Ruby goodness ****************************************************************
syntax on
filetype on
filetype indent on
filetype plugin on
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent

map <leader>r :!ruby %<cr>    " Run scripts easily

" Buffers **********************************************************************
" Shortcuts to go to next buffer, previous buffer, and delete a buffer
nmap <tab> :bnext<CR>
nmap <leader><tab> :bprevious<CR>
nnoremap <leader>bd :bp\|bd #<CR>

" Backups **********************************************************************
set backupdir=.~/.vim/tmp,/tmp     " Changes ~ location
set directory=~/.vim/tmp,/tmp      " Changes swp location

" Ctags ************************************************************************
set tags=.tags

" Regenerate tags
map <leader>ct :!ripper-tags -f .tags -R --exclude=vendor<cr>
" Follows the method call
map <leader>f <C-]>

" Window Management ************************************************************
set equalalways
set splitright
set splitbelow

" Faster splitting
noremap <leader>v :vsplit<cr>
noremap <leader>h :split<cr>

" Searching ********************************************************************
set hlsearch        " Highlight results
set incsearch       " Show matches while typing pattern
set ignorecase      " Case-insensitive search
set smartcase       " Case-sensitive when input contains an uppercase letter

"  kills search highlighting until next search
map <leader>, :silent nohlsearch<cr>

" Allows current selection to be substituted
" Usage: :%s//replacement/g
function SearchSelected()
  let save=@"
  norm! gvy
  let @/='\V'.escape(@",'\')
  let @"=save
endfunction
:vnoremap g/ <ESC>:call SearchSelected()<cr>


" show cwindow after running Ggrep
autocmd QuickFixCmdPost *grep* cwindow

" Easy Align *******************************************************************
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" NERDTree *********************************************************************
nmap <silent> <unique> <leader>n :NERDTreeToggle<cr>

" Git **************************************************************************
nmap <silent> <unique> <leader>m :Merginal<cr>
"autocmd BufReadPost fugitive://* set bufhidden=delete
"autocmd BufReadPost *.fugitiveblame set bufhidden=delete
"autocmd BufReadPost .git/* set bufhidden=delete
"autocmd BufReadPost GoToFile set bufhidden=delete

"nnoremap <silent> <leader>gd :Gdiff<cr>
"nnoremap <silent> <leader>gs :Gstatus<cr>
"nnoremap <silent> <leader>gs :Gstatus<cr><C-w>20+
""nmap <leader>gs :Gstatus<cr><C-w>20+
"nnoremap <silent> <leader>gw :Gwrite<cr>
"nnoremap <silent> <leader>gb :Gblame<cr>
"nnoremap <silent> <leader>gci :Gcommit<cr>
"nnoremap <silent> <leader>gm :Gmove<cr>
"nnoremap <silent> <leader>gr :Gremove<cr>
"nnoremap <silent> <leader>gl :Glog<cr>

"augroup ft_fugitive
"  au!
"  au BufNewFile,BufRead .git/index setlocal nolist
"augroup END

" FZF **************************************************************************
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "!{.DS_Store,.git,bower_components,cache,log,node_modules,tags,vendor}/*"
  \ -g "!tags" '
  "\ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
command! -bang -nargs=* FindWithin call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap t :exec 'FZF'<cr>

" Syntastic ****************************************************************
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']
