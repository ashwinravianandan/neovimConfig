return {
   {
      "zbirenbaum/copilot.lua",
      config = function()
         require("copilot").setup({
            {
               suggestion = { enabled = false },
               panel = { enabled = false },
            }
         })
      end,
      dependencies = {
         "copilotlsp-nvim/copilot-lsp"
      }
   },
   {
      "zbirenbaum/copilot-cmp",
      config = function()
         require("copilot_cmp").setup()
      end
   },
   {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
         { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
      },
   }
}
