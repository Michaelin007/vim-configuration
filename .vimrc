" Basic Settings
set number
set mouse=a
set tabstop=2
set autoindent
set expandtab
set softtabstop=4
set cursorline

" Completion Settings
set completeopt=menu,menuone,preview,noselect,noinsert

" ALE Configuration
let g:ale_completion_enabled = 1
let g:ale_fixers = {'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']}
let g:ale_linters = {
      \ 'rust': ['analyzer'],
      \ 'cs': ['syntax', 'semantic', 'issues'],
      \ 'python': ['pylint'],
      \ 'java': ['javac']
      \ }
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'
let g:ale_open_list = 0
let g:ale_loclist = 0

" Filetype and Syntax Settings
filetype plugin indent on
syntax on

" NERDTree Settings
autocmd VimEnter * NERDTree

" Plugin Manager (vim-plug)
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'junegunn/vim-javacomplete2'
  Plug 'Shougo/deoplete.nvim'
  Plug 'dense-analysis/ale'
  Plug 'rust-lang/rust.vim'
  Plug 'artur-shaik/vim-javacomplete2'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'SirVer/ultisnips'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'jiangmiao/auto-pairs' " Add auto-pairs plugin
call plug#end()

" Code Completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 2
let g:deoplete#sources = {
      \ '_': ['buffer', 'ultisnips', 'file', 'dictionary'],
      \ 'javascript': ['tern', 'omni', 'file', 'buffer', 'ultisnips']
      \ }
let g:deoplete#enable_smart_case = 1

" Completion with TAB
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

" CtrlP Settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'ctrlp'
let g:ctrlp_dont_split = 'nerd'
let g:ctrlp_working_path_mode = 'rw'
set wildignore+=*/.git/*,*/tmp/*,*.swp/*,*/node_modules/*,*/temp/*,*/Builds/*,*/ProjectSettings/*
let g:ctrlp_max_files = 0
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = {
      \ 'dir':  '',
      \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.meta|\.zip|\.rar|\.ipa|\.apk',
      \ }
function! CtrlPCommand()
  let c = 0
  let wincount = winnr('$')
  while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
    exec 'wincmd w'
    let c = c + 1
  endwhile
  exec 'CtrlP'
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'

" UltiSnips Settings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

" Java Settings
autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C.%#
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java JCEnable

" C Compilation and Running Settings
autocmd FileType c set makeprg=gcc\ %\ -o\ %<\ &&\ ./%<
autocmd FileType c set errorformat=%f:%l:%m

" Rust Compilation and Running Settings
autocmd FileType rust set makeprg=cargo\ run
autocmd FileType rust set errorformat=%f:%l:%c:\ %m
