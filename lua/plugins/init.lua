return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = "Find files" },
			{ '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = "Live grep" },
			{ '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = "Find buffers" },
			{ '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = "Help tags" },
			{ '<leader>fr', '<cmd>Telescope registers<cr>',  desc = "Find registers" },
			{ '<leader>fp', '<cmd>Telescope projects<cr>',  desc = "Find projects" }
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = '┊' },
			-- scope = { char = '▎', highlight = { "Function", "Label" } }
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { no_italic = true } },
	'tpope/vim-fugitive',
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",  -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua",              -- optional
			"echasnovski/mini.pick",         -- optional
		},
	},
	'tpope/vim-commentary',
	'vim-scripts/a.vim',
	'will133/vim-dirdiff',
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "norg", "norg_meta" },
				sync_install = false,
				ignore_install = {},
				modules = {},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ "nvim-dap-ui" },
				{ "nvim-dap" }
			},
		},
	}
}
