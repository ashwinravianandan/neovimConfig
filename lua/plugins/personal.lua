return {
	{
		'ashwinravianandan/vimProj',
		'ashwinravianandan/vimNotes',
		init = function()
			vim.g.project_command_hook = "BuildTags"
		end,
		keys = { { '<leader>pf', '<cmd>:call OpenProject()<CR>', desc = "Open Vim project" } }
	},
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = true,
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.export"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
							gtd = "~/gtd",
						},
						default_workspace = "notes",
					},
				},
				["core.integrations.telescope"] = {
					config = {
                  insert_file_link = {
                     show_title_preview = true
                  }
					}
				},
			},
		},
      dependencies = {
         { "nvim-lua/plenary.nvim" },
         { "nvim-neorg/neorg-telescope" }
      },
	},
   {
      "nvim-neorg/neorg-telescope",
		keys = { { '<leader>nf', '<Plug>(neorg.telescope.find_norg_files)', desc = "find files" } }
   }
}
