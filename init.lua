-- Editor Settings
vim.opt.autoindent = true 
vim.opt.autoread = true 
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.expandtab = true 
vim.opt.clipboard = 'unnamed'
vim.opt.laststatus = 2 
vim.opt.ruler = true
vim.opt.showcmd = true 
vim.opt.smartindent = true 
vim.opt.smarttab = true 
vim.opt.vb = true 
vim.opt.colorcolumn = '93'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 4
-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Code Tabbing
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Persistent Undo
-- TODO: the fix for this is below, commented out until then.
-- https://github.com/neovim/neovim/issues/15720
-- vim.opt.undodir = '~/.config/nvim/undodir'
-- vim.opt.undofile = true
-- Better Backups
-- vim.opt.backupdir = '~/.config/nvim/sessions'
-- vim.opt.dir = '~/.config/nvim/sessions'

vim.keymap.set({''}, '<CR>', ':noh<CR><CR>') -- clears highlighted search results

-- Disable netrw at the suggestion of nvim-tree
-- TODO: why?
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Package Management
-- Install Packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end
-- Install Plugins
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Theme inspired by Atom
  use 'joshdick/onedark.vim'
  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- File Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  -- File Finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- Spotify Controller
  use {
    'KadoBOT/nvim-spotify', 
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
        local spotify = require'nvim-spotify'

        spotify.setup {
            -- default opts
            status = {
                update_interval = 10000, -- the interval (ms) to check for what's currently playing
                format = '%s %t by %a' -- spotify-tui --format argument
            }
        }
    end,
    run = 'make'
}
  
  -- Simple Packages
  use 'junegunn/vim-easy-align'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'tpope/vim-commentary'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'tpope/vim-fugitive'
  use 'pechorin/any-jump.vim'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'tveskag/nvim-blame-line'

  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end

-- Easily Resync Configuration
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

-- Configure Installed Packages

vim.opt.termguicolors = true
vim.cmd('colorscheme onedark')

local status = require'nvim-spotify'.status
status:start()
require('lualine').setup({
  options = {
    icons_enabled = false,
    section_separators = '',
    component_separators = ''
  },
  sections = {
    lualine_x = {
      status.listen
    }
  }
})

require('nvim-tree').setup()
vim.keymap.set({''}, '<leader>d', ':NvimTreeToggle<CR>') -- toggle the file tree view

require('telescope').setup()
vim.keymap.set({''}, ';', ':Telescope find_files<CR>')
vim.keymap.set({''}, ',', ':Telescope live_grep<CR>')
vim.keymap.set({''}, '<leader>b', ':Telescope buffers<CR>')
require('telescope').load_extension('fzf')

vim.keymap.set({'v'}, '<Enter>', ':EasyAlign<Enter>', { silent = true })

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }
vim.keymap.set({''}, 'ig', ':IBLToggle<CR>')

require('nvim-treesitter.configs').setup({
  ensure_installed = { "ruby", "javascript", "typescript" },
  highlight = {
    enable = true
  }
})
require('nvim-treesitter.configs').setup {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif vim.fn["vsnip#available"](1) == 1 then
      feedkey("<Plug>(vsnip-expand-or-jump)", "")
    elseif has_words_before() then
      cmp.complete()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      feedkey("<Plug>(vsnip-jump-prev)", "")
    end
  end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Toggle git blame at the end of the line
vim.keymap.set({''}, 'gb', ':ToggleBlameLine<CR>')
