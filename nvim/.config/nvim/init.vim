" Plugins {{{1

let g:colourlist = ["chester", "spacedust", "OceanicNext", "startrail", "deus", "levuaska", "carbon", "spacegray"]
let g:currentcolour = trim(system("grep '^colorscheme' ~/.config/nvim/init.vim | head -1 | sed 's/colorscheme //'"))
let g:usinglightline = index(g:colourlist, g:currentcolour) < 0 "if colorscheme not in list

call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'SirVer/ultisnips'
Plug 'tommason14/vim-snippets'
if g:usinglightline
  Plug 'itchyny/lightline.vim'
endif
Plug 'junegunn/goyo.vim'               " Perfect for writing
Plug 'tomtom/tcomment_vim'             " Comments
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'arcticicestudio/nord-vim'
Plug 'ackyshake/Spacegray.vim'
Plug 'morhetz/gruvbox'
Plug 'tommason14/pywal.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'theniceboy/vim-deus'
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'github/copilot.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'dccsillag/magma-nvim', {'do': ':UpdateRemotePlugins'}
call plug#end()

" Basics {{{1

filetype plugin indent on
syntax enable
set encoding=utf-8 
set foldmethod=marker
set foldlevelstart=0
set backspace=2 " backspace works like other editors
set visualbell " no beeps!
set belloff=all " no flashes!
set showcmd " visual select shows number of lines
set splitright " automatically place new vertical splits on the right
set expandtab " tabs to spaces
set ruler
set linebreak " don't break words when wrapping to new line
set autoindent
set smarttab
set hidden
set formatoptions=tcqj
set wildmenu
set autoread " reload a file changed outside of vim
set noshowmode
set laststatus=2
set scrolloff=8 " start moving down when 8 rows from the bottom
set shortmess+=F " remove line that appears at bottom of file when opening
set mouse=a " move split borders with mouse while allowing the user to copy text with mouse

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.config/nvim'

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Searching {{{1
set ignorecase " ignore case while searching
set smartcase
set hlsearch   " highlight results
set incsearch  " search as you type

" Ultisnips {{{1

let g:UltiSnipsUsePythonVersion = 3
let g:python3_host_prog = 'python3'

" Load snippets

function Snippets()
  if g:local
    execute "tabnew ~/Documents/repos/vim-snippets/UltiSnips/".&ft.".snippets"
  else
    execute "tabnew ~/vim-snippets/UltiSnips/".&ft.".snippets"
  endif
endfunction

let g:snips_author="Tom Mason"
let g:snips_email="tommason14@gmail.com"
let g:snips_github="https:github.com/tommason14"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

au BufWinLeave *.snippets :FloatermNew --autoclose=2 update_snippets.sh

" Remapping {{{1 

let mapleader = ","

" Snippets

nnoremap <Leader>s :call Snippets()<CR>

" Alt-arrow to move splits
map <A-Up> <C-w><Up>
map <A-Down> <C-w><Down>
map <A-Right> <C-w><Right>
map <A-Left> <C-w><Left>

xnoremap <C-Up> :move '<-2<CR>gv-gv
xnoremap <C-Down> :move '>+1<CR>gv-gv
" control + up/down = page up/page down
" so leftmost key on mech. keyboard works as mac function key
" map <C-Up> <PageUp>
" map <C-Down> <PageDown>

" Try out additional escape
inoremap jj <Esc>

" Sort selected text alphabetically
vnoremap <Leader>s :sort<CR>

" Copy/paste to/from clipboard

nnoremap <Leader>y "*y
nnoremap <Leader>b "*p

" Toggle folds
nnoremap <Space> za

" Re-wrap paragraph for markdown
au FileType markdown nnoremap <silent> gq gqip

" Easy save
nnoremap <leader>w :w<CR>

" New lines
nnoremap o o<Esc>

" Navigation unaffected when soft wrapping
nnoremap j gj
nnoremap <Down> gj
inoremap <Down> <C-o>gj
nnoremap k gk
nnoremap <Up> gk
inoremap <Up> <C-o>gk

" Spell check - offer replacement
nnoremap <Leader><Space> z=

" Evaluate highlighted expression
" (https://vi.stackexchange.com/questions/13602/the-meaning-of-in-vim)
" Yank into register k first so that spaces are retained
" gv to re-select expression
" qkq to clear register
vnoremap <Leader>e "kygv"=<C-r>k<CR>pqkq 

" Run python in vim

" Run on selected text
" vnoremap <Leader>p3 y`]o<Esc>o<Esc>iOutput:<Esc>p`[v`]:!python3<CR>
vnoremap <Leader>p3 y`]o<Esc>p`[v`]:!python3<CR>
vnoremap <Leader>p2 y`]o<Esc>o<Esc>iOutput:<Esc>p`[v`]:!python<CR>

" Run on selected text, no output
vnoremap <Leader>n3 y`]p`[v`]:!python3<CR>
vnoremap <Leader>n2 y`]p`[v`]:!python<CR>

" Run on entire buffer
nnoremap <Leader>p3 :norm ggVG$,p3<CR>0:norm <C-v><C-v>GI# <CR>
nnoremap <Leader>p2 :norm ggVG$,p2<CR>0:norm <C-v><C-v>GI# <CR>

" Run on entire buffer, no output
nnoremap <Leader>pn3 :norm ggVG$,n3<CR>
nnoremap <Leader>pn2 :norm ggVG$,n2<CR>

" Float term commands
function LFfloaterm(command)
  let g:floaterm_open_command = a:command
  FloatermNew lf
endfunction

nnoremap <Leader>l :call LFfloaterm('edit')<CR>
nnoremap <Leader>t :call LFfloaterm('tabe')<CR>

nnoremap <Leader>fp :set ft=python<CR>i
nnoremap <Leader>b :set ft=sh<CR>i

" open vimrc
nnoremap <Leader>v :tabnew ~/.config/nvim/init.vim<CR>

" Format csv files in buffer
au BufRead,BufNewFile *csv nnoremap <Leader>r :Tabularize /,<CR>gg

" Remove spaces and return to original csv.
" For first line, remove double space ,\s or \s, but not between words
au BufRead,BufNewFile *csv nnoremap <Leader>x ggV:s/\s\s//g<CR>V:s/,\s/,/g<CR>V:s/\s*,/,/g<CR>jVG:s/\s//g<CR>gg

" Toggle comments - <Command>-/ mapped to ,c in iterm2
noremap <silent> <Leader>c :TComment<CR>

" Remove the highlighting after search, by removing after enter key is pressed
" regardless. <backspace> removes the :noh at bottom of editor
nnoremap <CR> :noh<CR>:<backspace>

" Reapply the custom spellcheck look
nnoremap <Leader>h :hi clear SpellBad<CR>:hi SpellBad cterm=underline<CR><CR>

" Toggle mouse
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

nnoremap <silent> <Leader>m :call ToggleMouse()<CR>

" Toggle line numbers 
function! ToggleLineNumbers()
    " check if line numbers are enabled
    if &number == '1'
        set nonumber
        set norelativenumber
    else
        set number 
        set relativenumber
    endif
endfunc 

nnoremap <silent> <Leader>n :call ToggleLineNumbers()<CR>

" Add undo break points 
inoremap , ,<C-g>u
inoremap . .<C-g>u

" Quickfix jumps, very useful with vimtex compilation issues 
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

" Python  {{{1 

au BufNewFile,BufRead *.py
    \ set tabstop=4                                  |
    \ set expandtab                                  |
    \ set softtabstop=4                              |
    \ set shiftwidth=4                               |
    \ set textwidth=100                              |
    \ let g:formatters_python=['black']              |
    \ let g:black_linelength=110                     |
    \ set filetype=python                            |
    \ set formatoptions=tcqj                         |

" italic docstrings, function calls etc...
au FileType python 
    \ syn region Comment start=/"""/ end=/"""/       |
    \ hi pythonFunction cterm=italic gui=italic      |
    \ hi pythonDecoratorName cterm=italic gui=italic |
    \ hi pythonBuiltin cterm=italic gui=italic       |

" Markdown/text files {{{1

au BufNewFile,BufRead *.md
    \ set tabstop=2                         |
    \ set softtabstop=2                     |
    \ set expandtab                         |
    \ set shiftwidth=2                      |
    \ set textwidth=79                      |
    \ set spell spelllang=en_gb             |
    \ syn match markdownError "\w\@<=\w\@=" | " Stops highlighting after subscripting in equations
    \ set filetype=markdown                 |

au BufNewFile,BufRead *.txt
    \ set tabstop=2                         |
    \ set softtabstop=2                     |
    \ set expandtab                         |
    \ set shiftwidth=2                      |
    \ set textwidth=79                      |
    \ set spell spelllang=en_gb             |
    \ set filetype=plain                    |

" LaTeX {{{1

au BufNewFile,BufRead *.tex
    \ set formatoptions=tc                  |
    \ set tabstop=2                         |
    \ set softtabstop=2                     |
    \ set expandtab                         |
    \ set shiftwidth=2                      |
    \ set textwidth=79                      |
    \ set filetype=tex                      |
    \ set spell spelllang=en_gb             |
    \ nnoremap <Leader>o :!open %:r.pdf <CR> |
    \ let b:copilot_enabled = 0 |

let g:vimtex_engine = 'xelatex'
let g:vimtex_view_method='zathura'           
let g:vimtex_quickfix_open_on_warning = 0 
set conceallevel=0                        
let g:tex_conceal='abdmg'                 

 " Shell {{{1

au BufNewFile,BufRead *.sh,bash*,*lfrc*,*alias*
    \ set tabstop=2                         |
    \ set softtabstop=2                     |
    \ set expandtab                         |
    \ set shiftwidth=2                      |
    \ set filetype=bash                     | " better syntax highlighting


" Config with Makefiles {{{1

function Compile_on_save()
  if filereadable('Makefile')
    ! make install
  endif
endfunction

au BufWritePost config.h call Compile_on_save()

" Visuals {{{1

set termguicolors
colo pywal 
let g:lightline = {'colorscheme': 'pywal'}

" set t_Co=256
" set background=dark
" set termguicolors
" colorscheme deus
" let g:lightline = {"colorscheme" : "deus"}
" hi linenr guibg=NONE
" hi cursorlinenr guibg=NONE
" hi folded guibg=NONE
" " Statusline is one solid colour if regular vim, so fix with line below:
" hi Statusline term=bold cterm=bold ctermfg=4 ctermbg=black

" let g:tokyonight_style='storm'
" colo tokyonight
" let g:lightline = {'colorscheme': 'tokyonight'}

" set termguicolors 
" let g:gruvbox_contrast_dark='hard'
" colo gruvbox 
" let g:lightline = {'colorscheme': 'gruvbox'}

" set termguicolors
" colorscheme spacegray
" hi linenr ctermbg=NONE guibg=NONE guifg=#85A7A5
" hi cursorlinenr ctermbg=NONE
" hi folded ctermbg=NONE
" hi Pmenu guifg=#A57A9E guibg=#1C1F20
" hi PmenuSel guifg=#95B47B guibg=#1C1F20
" " background is too dark, not sure why... so use terminal background instead
" hi Normal guibg=NONE 
" hi SignColumn guibg=NONE 
" hi LineNr guibg=NONE

" colo nord
" let g:lightline = {'colorscheme': 'nord'}
" hi Comment ctermfg=14 " brighter comments
" hi Folded ctermfg=14
" hi LineNr ctermfg=6

" Italic comments
" First vim needs to know which characters to see to 
" switch to italic mode
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
" then set italics
hi Comment cterm=italic gui=italic " Work for cases with and without `set termguicolors`
hi Folded cterm=italic gui=italic guibg=NONE ctermbg=NONE " Italic and use terminal colours

" Remove all backgrounds so that transparent background is used 
hi Normal guibg=NONE 
hi SignColumn guibg=NONE 
hi LineNr guibg=NONE 
hi MsgArea guibg=NONE
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

" Changes style of highlighting
hi clear SpellBad
hi SpellBad cterm=underline gui=underline
set spellcapcheck=""
hi clear SpellLocal
hi clear Error 

" Statusline hidden by lightline, shows if lightline not in use
source ~/.config/nvim/statusline.vim 

" Lsp config {{{1

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_sorting = 'none' "place python underscore methods at bottom

lua << EOF
local nvim_lsp = require('lspconfig')
local cmp = require('cmp')
local lspkind = require('lspkind')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'latex_symbols' },
      { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format({
        with_text = true,
        menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        ultisnips = "[snip]",
        },
    }),
  },
})


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- transparent Lsp column 
  vim.cmd[[ hi SignColumn guibg=NONE ]]

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd> lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- python
nvim_lsp.pylsp.setup{
 on_attach = on_attach,
 formatCommand={'black'}
}

-- go
nvim_lsp.gopls.setup{
 on_attach = on_attach,
}

-- markdown
nvim_lsp.zeta_note.setup{
  cmd = {'~/.local/bin/zeta-note'},
  on_attach = on_attach
}

-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

function echo_diagnostics(opts, bufnr, line_nr, client_id)
    opts = opts or {}
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    
    if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line_nr then
       return
    end

    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    if vim.tbl_isempty(line_diagnostics) then 
        -- If we previously echo'd a message, clear it out by echoing an empty
        -- message.
      if last_echo[1] then
        last_echo = { false, -1, -1 }
        vim.api.nvim_command('echo ""')
      end
      return
    end
    last_echo = { true, bufnr, line }
    local diagnostic_message = ""
    for i, diagnostic in ipairs(line_diagnostics) do
      diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
      if i ~= #line_diagnostics then
        diagnostic_message = diagnostic_message .. "\n"
      end
    end
    print(diagnostic_message)
end

  
EOF

" autoformat on save
autocmd BufWritePost *.py,*.R lua vim.lsp.buf.formatting()

" Lsp inline errors
hi LspDiagnosticsDefaultWarning cterm=italic gui=italic

" populate quickfix list with LSP info, and cycle through if needed

nnoremap <buffer> <silent> <leader>eq <cmd>lua vim.lsp.diagnostic.set_qflist()<CR>
nnoremap <buffer> <silent> <leader>cn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <buffer> <silent> <leader>cp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" Telescope stuff {{{1

lua << EOF
local tele = require('telescope')
tele.setup{
  defaults = {
    prompt_prefix = "$ "
  }
}
EOF

nnoremap <leader>ff :Telescope find_files<CR>

" cycle through buffers
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
" or with letters
nnoremap bn :bnext<CR>
nnoremap bp :bprev<CR>
nnoremap bd :bdelete<CR>
" or with tab key 
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <Leader>x :bdelete<CR>

