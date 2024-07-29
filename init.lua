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
vim.opt.ttimeoutlen = 100


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
    {'mbbill/undotree'},
    {'philrunninger/nerdtree-visual-selection'},
    {'Xuyuanp/nerdtree-git-plugin'},
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { 
            "nvim-lua/plenary.nvim" 
        }
    },
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
      config = function () require("copilot_cmp").setup() end,
      dependencies = {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
    },

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
vim.api.nvim_set_keymap('n', '<leader>o', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-o>', ':NERDTree<CR>', { noremap = true })


vim.api.nvim_set_keymap('n', '<S-L>', ':vertical resize +1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-H>', ':vertical resize -1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-J>', ':resize +1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-K>', ':resize -1<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-u>zz', { noremap = true })

-- Quick Edit
vim.api.nvim_set_keymap('n', '<leader>ev', '<cmd>e ~/dotfiles/init.lua<CR>', { noremap = true }) -- vim init.lua
vim.api.nvim_set_keymap('n', '<leader>et', '<cmd>e ~/dotfiles/tmux.conf<CR>', { noremap = true }) -- tmux.conf

-- Telescope config
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

-- Undo Tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Custom
vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>silent !tmux send-keys -t{bottom-left} "cd $(pwd)" C-m "clear" C-m<CR>', { noremap = true })

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

-- Harpoon2
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>x", function() harpoon:list():add() end)

vim.keymap.set("n", "<leader>s", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>d", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>f", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>g", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>h", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })


-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  }
}
