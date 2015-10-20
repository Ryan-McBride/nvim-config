"pathogen
execute pathogen#infect()
filetype plugin on
"general
set autoread

"UI
set ruler
set ignorecase
set number
set showmatch
set mat=3
color moria
set guifont=Hack

"pretty stuff
syntax on
set background=dark
set encoding=utf8
colorscheme molokai
let g:molokai_original = 1

"backup
set nobackup
set nowb
set noswapfile

"text stuff
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

"remaps
nmap s :w <CR>
nmap qq :q <CR>
nmap nt :NERDTreeTabsToggle <CR>
inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "<Right>" : ")" 
inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "<Right>" : "]" 
inoremap { {}<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "<Right>" : "}" 

" Quickly edit / reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"plugins:

  "syntastic
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_html_tidy_ignore_errors=[" lacks \"action\" attribute"]
  let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute "]
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  "airline
  set laststatus=2
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1 
