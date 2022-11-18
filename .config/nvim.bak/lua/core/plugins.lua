require('packer').startup(function(use)
  -- Package Manager
  use 'wbthomason/packer.nvim'

  -- Nvim optimization
  use 'lewis6991/impatient.nvim'

  -- Git
  use 'tpope/vim-fugitive'                                                  -- Git commands in nvim
  use 'tpope/vim-rhubarb'                                                   -- Fugitive-companion to interact with github
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups

  -- Commenting
  use 'numToStr/Comment.nvim'                                               -- "gc" to comment visual regions/lines

  -- Syntax Highlighting
  use 'nvim-treesitter/nvim-treesitter'                                     -- Highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                         -- Additional textobjects for treesitter

  -- Auto close HTML
  use 'windwp/nvim-ts-autotag'

  -- Parens Rainbow
  use 'p00f/nvim-ts-rainbow'

  -- Auto pair brackets
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  -- LSP
  -- use 'williamboman/mason.nvim'                                             -- Manage external editor tooling i.e LSP servers
  -- use 'williamboman/mason-lspconfig.nvim'                                   -- Automatically install language servers to stdpath
  use 'neovim/nvim-lspconfig'                                               -- Collection of configurations for built-in LSP client

  -- Formatting and Linting
  use 'sbdchd/neoformat'

  -- Auto Complete
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }         -- Autocompletion

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippet Engine
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }     -- Snippet Engine and Snippet Expansion

  -- Colorschemes
  use 'mjlbach/onedark.nvim'                                                -- Theme inspired by Atom
  use 'rebelot/kanagawa.nvim'

  -- Status line
  use 'nvim-lualine/lualine.nvim'                                           -- Fancier statusline

  -- Indentation guides
  use 'lukas-reineke/indent-blankline.nvim'                                 -- Add indentation guides even on blank lines

  -- Tabstop
  use 'tpope/vim-sleuth'                                                    -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

end)
