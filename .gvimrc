set background=dark
colorscheme solarized

set guioptions-=m			" No dumb menubar in gvim
set guioptions-=T			" No dumb toolbar in gvim
set guioptions-=r			" No dumb right scrollbar in gvim
set guioptions-=L			" No dumb left scrollbar in gvim

" Use ":set guifont=*" and "set guifont?" for picking font
:set guifont=Inconsolata:h18

" vertical line at 81 to tell us not to go further
let &colorcolumn="100"
highlight ColorColumn guibg=#663333

" macvim transparency
set transparency=10

" NERDTree: Single click for everything
let NERDTreeMouseMode=1
