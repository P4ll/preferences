source $VIMRUNTIME/vimrc_example.vim
" Vim with all enhancements
set langmenu=en_US
let $LANG = 'en_US'

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif

" Make std tab
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Turn off all sound
set belloff=all

set guifont=Consolas:h12
set guioptions-=T
set encoding=utf8
set number
set hlsearch
set nobackup
set nowritebackup
set noundofile
set guifont=DejaVu_Sans_Mono_for_PowerLine:h12:cRUSSIAN:qDRAFT
set background=dark

let g:XkbSwitchEnabled = 1
"let g:XkbSwitchLib = 'D:\PortableApps\gVimPortable\App\vim\vim80\libxkbswitch32.dll'
"let g:XkbSwitchLib = '/usr/local/lib/libg3kbswitch.so'
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
let g:XkbSwitchAssistSKeymap = 1    " for search lines

inoremap <C-c> <esc>

" Make std moves
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Set a leader key
let mapleader = "-"
" <leader>ev starts vsplit editing vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" <leader>sv using vimrc as source
nnoremap <leader>sv :source $MYVIMRC<cr>

"set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Std backspace behavior
" set backspace=indent,eol,start
" set backup
" set backupdir='d:\Programs\Vim\backups\'

"if empty(glob($VIMRUNTIME . '\autoload\plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/vim-nerdtree/nerdtree'
Plug 'https://github.com/iamcco/markdown-preview.nvim'
Plug 'https://github.com/vim-nerdtree/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/powerline/fonts'
Plug 'lifepillar/vim-solarized8'
Plug 'https://github.com/grwlf/xkb-switch'
Plug 'https://github.com/lyokha/vim-xkbswitch'
Plug 'https://github.com/jamessan/vim-gnupg'
"Plug 'klen/python-mode'
"Plug 'vim-scripts/CSApprox'
"Plug 'https://github.com/tpope/vim-unimpaired'
"Plug 'valloric/youcompleteme'
"Plug 'JamshedVesuna/vim-markdown-preview'
"Plug 'iamcco/markdown-preview.vim'
Plug 'https://github.com/easymotion/vim-easymotion'
"Plug 'flazz/vim-colorschemes'
"Plug 'xolox/vim-colorscheme-switcher'
"Plug 'xolox/vim-misc'
call plug#end()
colo solarized8_flat
map <C-n> :NERDTreeToggle<CR>

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"if $DISPLAY == "" 
"	let g:XkbSwitchEnabled = 0
"else
"	let g:XkbSwitchEnabled = 1
"    let g:XkbSwitchLib = 'D:\PortableApps\gVimPortable\Data\libxkbswitch32.dll'
"	let g:XkbSwitchIMappings = ['ru']
"endif 

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
