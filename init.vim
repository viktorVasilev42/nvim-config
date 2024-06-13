call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/preservim/nerdtree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'https://github.com/windwp/nvim-ts-autotag'
Plug 'https://github.com/rebelot/kanagawa.nvim'
Plug 'https://github.com/rose-pine/neovim'

" nvim-comp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
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

let g:airline_theme="deus"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:vsnip_snippet_dir = "C:/Users/viktor/AppData/Local/nvim/snippets"

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
nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR> 

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

lua << EOF
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {
        }    
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
vim.cmd("colorscheme kanagawa");
vim.cmd(":highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE")
vim.cmd(":highlight MatchParen gui=underline guibg=black guifg=NONE")

require('mason').setup();

-- TreeSitter Settings

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "java", "lua", "python", "html", "javascript", "typescript", "cpp"},

  sync_install = false,

  auto_install = false,

  highlight = {
    enable = true,
  },

  indent = {
    enable = false    
  }
}

require("nvim-autopairs").setup {}

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
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
  require("lspconfig").tsserver.setup{
  }
  require("lspconfig").clangd.setup{}

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
