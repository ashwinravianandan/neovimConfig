return {
   {
      'majutsushi/tagbar',
      keys = {{ '<leader>tb', '<cmd>TagbarToggle<CR>', "show tagbar" }}
   },
   'godlygeek/tabular',
   'octol/vim-cpp-enhanced-highlight',
   'vim-scripts/STL-Syntax',
   'flazz/vim-colorschemes',
   -- {
   --    'vim-airline/vim-airline',
   --    init = function()
   --       if vim.fn.exists(vim.g.airline_symbols) == 0 then
   --          vim.g.airline_symbols = {
   --             branch = '',
   --             readonly = '',
   --             linenr = ' .',
   --             maxlinenr = '☰ ',
   --             dirty = '⚡'
   --          }
   --       end
   --       vim.g.airline_left_sep = ''
   --       vim.g.airline_right_sep = ''
   --       vim.g.airline_theme = 'catppuccin'
   --    end
   -- },
   {
      'nvim-lualine/lualine.nvim',
      opts = {
         sections = {
            lualine_c = {
               {
                  'filename',
                  show_filename_only = false,
                  path=1
               }
            }
         },
         theme = "auto"
      },
      dependencies = { 'nvim-tree/nvim-web-devicons' }
   }
}
