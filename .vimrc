set nu
syntax enable
set nocompatible
filetype off
set smartcase "according to a tip, this will make my searches ignore case when appropriate
"Always start in this directory
cd ~/text/
source ~/.vim/vim_config_adds/remaps.vim
source ~/.vim/vim_config_adds/iabbrev.vim
setlocal spell spelllang=en_us

"remaps keys to make interaction with .vimrc easier
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"from reedes vim-colors-pencil underline misspelled words
let g:pencil_spell_undercurl = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

let @t=':%s/\s\+$//e'
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'reedes/vim-colors-pencil'
Plugin 'reedes/vim-pencil'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'reedes/vim-lexical'
Plugin 'flazz/vim-colorschemes'
Plugin 'vimoutliner/vimoutliner'
Plugin 'reedes/vim-wordy'
Plugin 'taskpaper/taskpaper'
"Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
"Plugin '/home/linuxbrew/.linuxbrew/bin/fzf'
"Plugin '/usr/local/bin/fzf'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plugin 'junegunn/fzf.vim'
call vundle#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

"This is part of the vim-wordy plugin to help improve prose
let g:wordy#ring = [
  \ 'weak',
  \ ['being', 'passive-voice', ],
  \ 'business-jargon',
  \ 'weasel',
  \ 'puffery',
  \ ['problematic', 'redundant', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ 'art-jargon',
  \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
  \ 'adjectives',
  \ 'adverbs',
  \ ]

"Activates spellchecking with US english for vim-lex
"ical
let g:lexical#spell = 1         " 0=disabled, 1=enabled
let g:lexical#spelllang = ['en_us']

"For vim-airline, enable this for better symbols
let g:airline_powerline_fonts = 1

"The following are for taskpaper plugin
let g:task_paper_date_format = "%Y-%m-%dT%H:%M:%S%z"
let g:task_paper_follow_move = 0
let g:task_paper_styles={'wait': 'ctermfg=Blue guifg=Blue', 'FAIL': 'ctermbg=Red guibg=Red'}

filetype plugin indent on
set incsearch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

func! WordProcessorMode()
 setlocal textwidth=80
 setlocal smartindent
 setlocal spell spelllang=en_us
 setlocal noexpandtab
endfu

com! WP call WordProcessorMode()

"colorscheme tokyo-metro
colorscheme 0x7A69_dark
"from tim pope, automatically aligns tables built with the '|' symbol
"https://gist.github.com/tpope/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"end of tim pope cucumber table stuff
