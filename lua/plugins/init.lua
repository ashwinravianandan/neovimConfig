return {
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
         { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = "Find files" },
         { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = "Live grep" },
         { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = "Find buffers" },
         { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = "Help tags" }
      }
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
         indent = { char = '┊' },
         scope = { char = '▎', highlight = { "Function", "Label" } }
      },
   },
   { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts={no_italic = true} },
   'tpope/vim-fugitive',
   'tpope/vim-commentary',
   'vim-scripts/a.vim',
   'will133/vim-dirdiff',
   'nvim-treesitter/nvim-treesitter',
}
