"=======================================================================
"   vim-plug
"-----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Visual & Beauty
Plug 'morhetz/gruvbox'                " My beloved colorscheme
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'         " Devicons for file types
Plug 'preservim/nerdtree'             " Tree Explorer
Plug 'junegunn/goyo.vim'              " Distraction-free writing
Plug 'junegunn/limelight.vim'         " Hyperfocus writing by changing line opacity

" Funcionality Enhancement for Coding
Plug 'neoclide/coc.nvim', { 'branch': 'release' }   " Conquer of Completion
"Plug 'sheerun/vim-polyglot'    " Makes startups SOOO slow!
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tmux-plugins/vim-tmux-focus-events' " Enabling focus events like gvim
Plug 'kien/ctrlp.vim'                 " ctrlp fuzzy file finder

call plug#end()
" End of the plugin list


"=======================================================================
"   Basic Configurations
"-----------------------------------------------------------------------
"set autoread                        " Reload on external file changes
"set backspace=indent,eol,start      " backspace behavior
"set clipboard=unnamed,unnamedplus   " Enable clipboard
set mouse=a                         " Enable mouse support

filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set directory=$HOME/.vim/swp//      " Handle swap files in a separate folder
set backupdir=~/.vim/.backup//      " Handle backup files in a separate folder

set autoread                         " Automatically update buffer with newest changes
au FocusGained,BufEnter * :checktime " Trigger autoread when changing buffers

"=======================================================================
"   Colorscheme & Visual Configurations
"-----------------------------------------------------------------------

" Make lightline visible on startup.
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
      \   'right': [ [ 'lineinfo', ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'] ]
			\ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ 'component_expand': {
      \   'coc_error': 'LightlineCocErrors',
      \   'coc_warning': 'LightlineCocWarnings',
      \   'coc_info': 'LightlineCocInfos',
      \   'coc_hint': 'LightlineCocHints',
      \   'coc_fix': 'LightlineCocFixes',
      \ },
      \ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = ''
  endtry
  return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'hint')
endfunction

autocmd User CocDiagnosticChange call lightline#update()

" Gruvbox theme
set termguicolors   " 256-colors (so vivid!)
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox
set background=dark

highlight Comment cterm=italic gui=italic
set number relativenumber
set cursorline    " Highlight the line under the cursor
set colorcolumn=72,79   " Line length limit

" Shortcut for toggling NERDTree
"map <C-j> :NERDTreeToggle<CR>
nmap <leader>t :NERDTreeToggle<CR>

set termbidi  " To support rtl for Farsi & Arabic

set hlsearch  " Highlight searches

" Goyo Settings
nmap <leader>g :Goyo<CR>

function! s:goyoEnter()
  "Limelight0.7
  set colorcolumn=72    " Only comment bar needs to be shown
  highlight ColorColumn guibg=#3C3836 guifg=#EBDBB2
endfunction

function! s:goyoLeave()
  "Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyoEnter()
autocmd! User GoyoLeave nested call <SID>goyoLeave()

"=======================================================================
"   Functionality Enhancing Configurations
"-----------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:fake_src_paths = ['/home/saeed/.vim/plugged/vim-fake/src']

" Change .ejs filetypes to .html
au BufRead,BufNewFile *.ejs set filetype=html

" Disable folding in markdown files.
let g:vim_markdown_folding_disabled = 1

" Scrolling another window without switching to it.
nnoremap <leader>wd :<C-U>call win_execute(win_getid(winnr('#')), "normal! \<C-D>")<CR>
nnoremap <leader>wu :<C-U>call win_execute(win_getid(winnr('#')), "normal! <Bslash><lt>C-U>")<CR>

"=======================================================================
"   Conquer of Completion (Coc) configuration
"-----------------------------------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for dispalying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Running prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"==============================================
" coc-snippets configuration
"----------------------------------------------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

"=======================
" Black Configurations
"-----------------------
" Format on save.
autocmd BufWritePre *.py execute ':Black'

" Run Black on F9.
nnoremap <F9> :Black<CR>
