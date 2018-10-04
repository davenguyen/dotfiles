set nocompatible        " Better safe than sorry

call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized' " solarized colorscheme
  Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
  Plug 'idanarye/vim-merginal'    " git branching goodness
  Plug 'junegunn/fzf', { 'dir': '~/.dotfiles/.vim/plugin/fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'  " Text alignment
  Plug 'mhinz/vim-signify'        " Inline git diff
  Plug 'morhetz/gruvbox' " gruvbox colorscheme
  Plug 'scrooloose/nerdtree'      " Better file explorer
  "  Plug 'scrooloose/syntastic'     " Syntax checker
  Plug 'slim-template/vim-slim'   " Slim goodness
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
set hidden                         " hide buffers instead of closing

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

" Easy Align *******************************************************************
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" NERDTree *********************************************************************
nmap <silent> <unique> <leader>n :NERDTreeToggle<cr>

" Git **************************************************************************
nnoremap <leader>ga  :Gcommit --amend<cr>
nnoremap <leader>gb  :MerginalToggle<cr>
nnoremap <leader>gc  :Gcommit<cr>
nnoremap <leader>gd  :Gdiff<cr>
nnoremap <leader>gg  :Gstatus<cr>
nnoremap <leader>gl  :Glog -- %<cr><cr>
nnoremap <leader>gr  :Git rebase -i HEAD~
nnoremap <leader>gra :Git rebase --abort<cr>
nnoremap <leader>grc :Git rebase --continue<cr>
nnoremap <leader>gs  :Git stash<cr>
nnoremap <leader>gsa :Git stash apply<cr>
nnoremap <leader>gsd :Git stash drop<cr>

" show cwindow after running Ggrep
autocmd QuickFixCmdPost *grep* cwindow

" Signify **********************************************************************

" These are already mapped from gitgutter, I just didn't want to forget them
"[c          " Go to previous hunk
"]c          " Go to previous hunk

" TODO: This is a feature I miss from gitgutter that I need to get back
"<leader>hs  " Save hunk
"<leader>hu  " Undo hunk

" FZF **************************************************************************
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "!{.DS_Store,.git,bower_components,cache,log,node_modules,tags,vendor}/*"
  \ -g "!tags" '
  "\ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
command! -bang -nargs=* FindWithin call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap t :exec 'FZF'<cr>

" Syntastic ********************************************************************
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']
