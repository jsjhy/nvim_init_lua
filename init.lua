-- auto install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.o.encoding = 'UTF-8'
vim.opt.termguicolors = true


vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
--key map
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true } -- 复用 opt 参数
--
map("n", "<leader>w", "<C-w>w", opt) 
map("n", "<leader>f", ":NvimTreeOpen<cr>",opt) 
map("n", "<leader>b", ":BufferLineCyclePrev<CR>", opt) 
-- write back
map("n", "w", ":write<CR>", opt)
-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

--配置插件

require("lazy").setup({
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },
    -- Configure LazyVim to load gruvbox
    {
	"LazyVim/LazyVim",
	opts = {
	    colorscheme = "gruvbox",
	},
    },
    --
    --{
    --	"folke/tokyonight.nvim",
    --	lazy = false,
    --	priority = 1000,
    --	opts = {},
    --  },
    --
    {
	'akinsho/bufferline.nvim', 
	config =function()
	    require("bufferline").setup({
		options = {
		    offsets = {{
			filetype = "NvimTree",
			text = "File Explorer",
			highlight = "Directory",
			text_align = "left"
		    }},
		},
		highlights = {
		    tab_selected = {
			fg = 'Grey',
			bg = 'Black'
		    },
		    tab = {
			fg = 'White',
			bg = 'green'
		    },
		    buffer_selected = {
			bg = 'Grey',
			fg = 'LightGreen',
			bold = true,
			italic = true,
		    },
		},
	    })
	end,
	dependencies= 'kyazdani42/nvim-web-devicons',
	dependencies= 'folke/tokyonight.nvim'
    },
    --
    {
	'kyazdani42/nvim-tree.lua',
	config = function()
	    require("nvim-tree").setup({
	    })
	end,
	dependencies= 'kyazdani42/nvim-web-devicons'
    },

    --
    {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 300
	end,
	opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	}
    },

    --
    {
	'nvim-lualine/lualine.nvim',
	config = function()
	    require("lualine").setup({
		sections = {
		    lualine_c={{'filename',path=1}},
		},
		options  = {
		    scheme = "gruvbox", --theme = 'tokyonight',
		},
	    })
	end,
	dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",


})
