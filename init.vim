" ===============================================================

" ===============================================================
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" ===============================================================
" Plugins will be downloaded under the specified directory.
if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" ===============================================================
" File Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" ===============================================================
" THEME
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'wittyjudge/gruvbox-material.nvim'
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'Mofiqul/vscode.nvim'
" Plug 'navarasu/onedark.nvim'
Plug 'tanvirtin/monokai.nvim'
" ===============================================================
" AutoComplete
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
" ===============================================================
" Indent blank line
Plug 'lukas-reineke/indent-blankline.nvim'

" Scroll smooth 
Plug 'psliwka/vim-smoothie'

" Plug 'altercation/vim-colors-solarized'
" ===============================================================
" Syntax
Plug 'hail2u/vim-css3-syntax'
" Plug 'pangloss/vim-javascript'
" ===============================================================
" add this line to your .vimrc file
Plug 'mattn/emmet-vim'
" ===============================================================
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Pocco81/AutoSave.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-lualine/lualine.nvim'
Plug 'norcalli/nvim-colorizer.lua'
" ===============================================================
" Better file browser
Plug 'scrooloose/nerdtree'
" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

" Vim plugin for .tmux.conf
Plug 'tmux-plugins/vim-tmux'

" Adds icons to vim plugins
Plug 'ryanoasis/vim-devicons'
" useful overview of the code as a minimap sidebar.
Plug 'severin-lemaignan/vim-minimap'
" Code commenter
" Plug 'scrooloose/nerdcommenter'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'neoclide/vim-jsx-improve'
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
" Plug 'nvim-lua/plenary.nvim'
"Plug 'rktjmp/git-info.vim'
" Vim plugin for LaTeX
" Plug 'lervag/vimtex'


" Override configs by directory
" Plug 'arielrossanigo/dir-configs-override.vim'


" ===============================================================
" Eclipse TaskList hapus bentar
" ===============================================================
" Plug 'fisadev/FixedTaskList.vim'
" ===============================================================
" Plug 'vim-scripts/TaskList.vim'


" Deoplete
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif
" A universal set of defaults that (hopefully) everyone can agree on
"Plug 'tpope/vim-sensible'

" Comment stuff out
"Plug 'tpope/vim-commentary'

" quoting/parenthesis made simple
"Plug 'tpope/vim-surround'

" Automatically close parenthesis, etc
"Plug 'Townk/vim-autoclose'
" Format code with one button press (or automatically on save).
" Plug 'Chiel92/vim-autoformat'
" continuously updated session files
"Plug 'tpope/vim-obsession'

" Git integration
"Plug 'tpope/vim-fugitive'

" Shows a git diff in the gutter (sign column) and stages/undoes hunks.
"Plug 'airblade/vim-gitgutter'

" Better language packs
"Plug 'sheerun/vim-polyglot'
" Displaying thin vertical lines at each indentation level
" Plug 'Yggdroot/indentLine'
" Indent Guides is a plugin for visually displaying indent levels in Vim.
"Plug 'nathanaelkane/vim-indent-guides'


" Large collection of vim colorschemes
" Plug 'flazz/vim-colorschemes'

" A simple tool for presenting slides in vim based on text files.
"Plug 'sotte/presenting.vim'



" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" ===============================================================
" GLOBAL CONFIGURATION
syntax enable
set title
set encoding=utf-8
set number
set relativenumber
set cursorline
set ruler
set scrolloff=4
set showtabline=2
set clipboard=unnamedplus
set autoindent
set smartindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" set textwidth=79
" set colorcolumn=+1
set smarttab
" set nowrap
set nofoldenable
set ignorecase
set smartcase
set autoread
set noerrorbells
set novisualbell
set termguicolors
set completeopt+=noinsert
set completeopt-=preview
"set wildmode=list:longest
set shell=/bin/bash
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set mouse=a
" ===============================================================
" COLORSCHEME CONFIGURATION
" colorscheme kolo
colorscheme tokyonight-moon
" colorscheme monokai_pro
" coloscheme space-vim-dark
" colorscheme dracula
" colorscheme tokyonight-moon
" let g:seoul256_background = 234
" colorscheme seoul256
" colorscheme seti
" colorscheme darkspectrum
" colorscheme wombat
" colorscheme spacegray
" colorscheme codedark
" colorscheme gruvbox
" colorscheme nord
" ===============================================================
" AIRLINE CONFIGURATION
" set airline theme
" let g:airline_theme = 'wombat'
" let g:airline_theme = 'onedark'
let g:airline_theme = 'tomorrow'
" let g:airline_theme = 'base16'
" displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" separators can be configured independently for the tablne
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" populate the g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
" ===============================================================
" INDENTLINE CONFIGURATION
" " customize conceal color
" let g:indentLine_color_term = 239
" " customize conceal color
" " let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_char_list = ['┊']
" ===============================================================
" INDENTGUIDE CONFIGURATION
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level           = 1
let g:indent_guides_auto_colors           = 1
let g:indent_guides_color_change_percent  = 10
let g:indent_guides_space_guides          = 1
let g:indent_guides_tab_guides            = 1
let g:indent_guides_guide_size            = 1
let g:indent_guides_exclude_filetypes     = ['help', 'nerdtree', 'startify', 'Preview','__doc__','rst']
" ===============================================================
" Emmet vim "
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='<C-Z>'

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ===============================================================
" CSS3 syntax
augroup VimCSS3Syntax
autocmd!

autocmd FileType css setlocal iskeyword+=-
augroup END
" ===============================================================
" CUSTOM MAPPINGS
" Disable arrow keys
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>
" tab navigation mappings
map tt :tabnew
map tb :tabNext
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>
" clear search results
nnoremap <silent> // :noh<CR>
" ===============================================================
" DOEPLETE CONFIGURATION
let g:deoplete#enable_at_startup = 1
" ===============================================================
" FZF CONFIGURATION
nnoremap <C-p> :<C-u>FZF<CR>
" ===============================================================
" TASKLIST CONFIGURATION
" show pending tasks list
map <F2> :TaskList<CR>
" ===============================================================
" NERDTREE CONFIGURATION
" automatically open nerdtree when no file name specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" ===============================================================
" " NERDCOMMENTER CONFIGURATION
" " Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'
" ===============================================================
" AUTOCLOSE ISORT CONFIGURATION
" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
" ==============================================================
" ISORT CONFIGURATION
" let g:vim_isort_python_version = 'python3'
" ==============================================================
" MINIMAP CONFIGURATION
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'
" ===============================================================
" VIMTEX CONFIGURATION
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" ===============================================================
" VIM_DEV_ICONS CONFIGURATION
" loading the plugin
let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" adding the custom source to unite
let g:webdevicons_enable_unite = 1
" adding the column to vimfiler
let g:webdevicons_enable_vimfiler = 1
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1
" adding to vim-startify screen
let g:webdevicons_enable_startify = 1
" adding to flagship's statusline
let g:webdevicons_enable_flagship_statusline = 1
" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1
" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1
" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" Adding the custom source to denite
let g:webdevicons_enable_denite = 1
" ===============================================================




" hi Normal guifg=#44cc44 guibg=NONE ctermbg=none
" hi Normal guibg=NONE ctermbg=none
