call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/preservim/nerdtree'
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'https://github.com/windwp/nvim-ts-autotag'
Plug 'EdenEast/nightfox.nvim'

" nvim-comp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'https://github.com/mfussenegger/nvim-lint'
Plug 'https://github.com/lewis6991/gitsigns.nvim'
Plug 'https://github.com/tpope/vim-fugitive'

call plug#end()

:set number
:set relativenumber
:set noswapfile
:filetype plugin on

:set background=dark

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set smartindent
set smarttab

" let g:airline_theme="distinguished"
let g:airline_theme="viksa"
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#buffers_label = ''

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_y = '%{&fileencoding}'
let g:airline_section_z = '%l/%L %c'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_airline_tabline = 0

let g:vsnip_snippet_dir = "/home/viktor/.config/nvim/snippets/"

nnoremap <leader>e :lua vim.diagnostic.open_float(nil, { scope = "line" })<CR>

" Motion Mappings
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap j jzz
nnoremap k kzz

" Telescope Mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>


" jdtls Mapping

nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ty <cmd>lua vim.lsp.buf.hover()<CR>

" NERDTree Settings

let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeShowHidden = 1

"" Highlighting
let g:WebDevIconsDefaultFolderSymbolColor = "EE6E73"
let g:NERDTreeExtensionHighlightColor = {}

function! ToggleOrFocusNERDTree()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        if bufname('%') =~ 'NERD_tree'
            execute "NERDTreeClose"
        else
            execute "NERDTreeFocus"
        endif
    else
        execute "NERDTreeToggle"
    endif
endfunction

nmap <C-f> :call ToggleOrFocusNERDTree()<CR>

augroup set_html_filetype
  autocmd!
  autocmd BufReadPost,BufNewFile *.html set filetype=html
augroup END

augroup set_prolog_filetype
    autocmd!
    autocmd BufReadPost,BufNewFile *.pl set filetype=prolog
augroup END

augroup fix_php_indent
    autocmd!
    autocmd FileType php setlocal indentexpr=
    autocmd FileType php setlocal autoindent
    autocmd FileType php setlocal smartindent
augroup END

lua << EOF

-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme duskfox")

vim.cmd(":highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE")
vim.cmd(":highlight MatchParen gui=underline guibg=black guifg=NONE")
vim.cmd(":highlight CurSearch ctermfg=LightBlue guifg=#a3be8c guibg=#363943")


require('mason').setup();

-- TreeSitter Settings

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "java", "lua", "python", "html", "javascript", "typescript", "css", "php", "clojure"},

  sync_install = false,

  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  indent = {
    enable = false
  }
}

require("nvim-autopairs").setup {}
require("nvim-autopairs").get_rules("'")[1].not_filetypes = { "clojure" }

-- nvim-comp setup
 -- Set up nvim-cmp.
  local cmp = require 'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion:
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]--

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require("lspconfig")['pyright'].setup {
      capabilities = capabilities;
      filetypes = {"python"}
  }
  require("lspconfig")["html"].setup {
      capabilities = capabilities;
      filetypes = {"html",}
  }
  require("lspconfig").cssls.setup{}
  require("lspconfig").clangd.setup{}
  require("lspconfig").eslint.setup{}
  require("lspconfig").lua_ls.setup{}
  require("lspconfig").phpactor.setup({
    root_dir = function ()
        return vim.loop.cwd()
    end,
  })
  require("lspconfig").clojure_lsp.setup{
      cmd = { "/home/viktor/.local/share/nvim/mason/bin/clojure-lsp" },
      filetypes = { "clojure", "edn" },
      root_dir = function ()
        return vim.loop.cwd()
      end,
  }

  -- nvim-lint setup
  require('lint').linters_by_ft = {
      python = {'flake8',}
  }
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })

    -- Set up nvim-ts-autotag
    require('nvim-ts-autotag').setup({
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    })

    require("gitsigns").setup()
EOF
