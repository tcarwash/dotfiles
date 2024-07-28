-- Set options
vim.opt.number = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.statusline = '%F'
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.autoindent = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

-- Package Manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- Package Installation
require('lazy').setup({
    {'itchyny/lightline.vim'},
    {'tpope/vim-commentary'},
    {'tpope/vim-surround'},
    {'tpope/vim-vinegar'},
    {'APZelos/blamer.nvim'},
    {'joshdick/onedark.vim'},
    {'christoomey/vim-tmux-navigator'},
    {'danilo-augusto/vim-afterglow'},
    {'ajmwagar/vim-deus'},
    {'altercation/vim-colors-solarized'},
    {'preservim/nerdtree'},
    {
        'nvim-treesitter/nvim-treesitter',
        config = function() require('nvim-treesitter.configs').setup { 
            highlight = { enable = true } 
        } end
    },
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope.nvim'},
    {'nvim-tree/nvim-web-devicons'},
    {'ryanoasis/vim-devicons'},  
    {'folke/tokyonight.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'williamboman/mason.nvim'},
    { "sitiom/nvim-numbertoggle" },
    {'williamboman/mason-lspconfig.nvim'},
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { 
            "nvim-lua/plenary.nvim" 
        }
    }
    })

-- Theming
vim.g.lightline = {
  colorscheme = 'PaperColor',
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'absolutepath', 'modified' } }
  }
}

vim.cmd('colorscheme afterglow')
vim.opt.background = 'dark'
vim.opt.colorcolumn = '80'

-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('c', 'sudow', 'w !sudo tee % >/dev/null', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':ls<CR>:b<Space>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':NerdTreeFocus<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-o>', ':NERDTree<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-g>', ':vertical resize +1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':vertical resize -1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-d>', ':resize +1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':resize -1<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'J', [[:<C-U>exec "norm m`" \\| move + . (0+v:count1)<CR>==``]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', [[:<C-U>exec "norm m`" \\| move - . (1+v:count1)<CR>==``]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'J', [[:<C-U>exec "'<,'>move '>+" . (0+v:count1)<CR>gv=gv]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'K', [[:<C-U>exec "'<,'>move '<-" . (1+v:count1)<CR>gv=gv]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

-- Git Blame
vim.g.blamer_enabled = 1
vim.g.blamer_date_format = '%e %b %Y @ %H:%M'
vim.cmd('highlight Blamer guifg=darkorange')

-- LSP
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local async = require "plenary.async"
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})


-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  }
}
