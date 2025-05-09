--- LSP related plugins

return {
   { 'nvimdev/lspsaga.nvim', opts = {} },
   {
      "williamboman/mason.nvim",
      version = "^1.0.0",
      opts = {}
   },
   {
      "williamboman/mason-lspconfig.nvim",
      version = "^1.0.0",
      opts = {
         ensure_installed = { "clangd", "lua_ls" },
      }
   },
   {
      'mfussenegger/nvim-dap',
      config = function()
         local dap = require('dap')
         dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/bin/lldb-dap-18',
            name = 'lldb'
         }
         dap.configurations.cpp = {
            {
               name = 'Launch',
               type = 'lldb',
               request = 'launch',
               program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
               end,
               cwd = '${workspaceFolder}',
               stopOnEntry = false,
               args = {},

               -- 💀
               -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
               --
               --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
               --
               -- Otherwise you might get the following error:
               --
               --    Error on launch: Failed to attach to the target process
               --
               -- But you should be aware of the implications:
               -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
               -- runInTerminal = false,
            },
            {
               name = "Attach to process",
               type = "lldb",
               request = "attach",
               pid = function()
                  return require("personal.dap_utils").pick_process_id()
               end,
               args = {},
            },
         }
      end,

      keys = {
         { '<F5>',       function() require('dap').continue() end,          desc = "Continue execution" },
         { '<F10>',      function() require('dap').step_over() end,         desc = "Step over" },
         { '<F11>',      function() require('dap').step_into() end,         desc = "Step into" },
         { '<F12>',      function() require('dap').step_out() end,          desc = "Step out" },
         { '<Leader>b',  function() require('dap').toggle_breakpoint() end, desc = "toggle breakpoint" },
         { '<Leader>dr', function() require('dap').repl.open() end,         desc = "toggle breakpoint" },
      }
   },
   {
      "rcarriga/nvim-dap-ui",
      config = function()
         local dap, dapui = require("dap"), require("dapui")
         dapui.setup();
         dap.listeners.before.attach.dapui_config = function()
            dapui.open()
         end
         dap.listeners.before.launch.dapui_config = function()
            dapui.open()
         end
         dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
         end
         dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
         end
      end,
      dependencies = {
         "mfussenegger/nvim-dap",
         "nvim-neotest/nvim-nio"
      }
   },
   {
      'neovim/nvim-lspconfig',
      config = function()
         -- Set up lspconfig.
         local capabilities = require('cmp_nvim_lsp').default_capabilities()
         -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
         require('lspconfig')['clangd'].setup {
            capabilities = capabilities
         }

         require('lspconfig')['lua_ls'].setup {
            capabilities = capabilities
         }

         require 'lspconfig'.lua_ls.setup {
            on_init = function(client)
               if client.workspace_folders then
                  local path = client.workspace_folders[1].name
                  if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                     return
                  end
               end

               client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = {
                     -- Tell the language server which version of Lua you're using
                     -- (most likely LuaJIT in the case of Neovim)
                     version = 'LuaJIT'
                  },
                  -- Make the server aware of Neovim runtime files
                  workspace = {
                     checkThirdParty = false,
                     library = {
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                     }
                     -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                     -- library = vim.api.nvim_get_runtime_file("", true)
                  }
               })
            end,
            settings = {
               Lua = {}
            }
         }
         --- autocommands setup
         vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
               local opts = { noremap = true, silent = true }
               vim.keymap.set('n', 'K', '<cmd> Lspsaga hover_doc<CR>', opts)
               vim.keymap.set('n', '<leader>a', '<cmd> Lspsaga code_action<CR>', opts)
               vim.keymap.set('n', '<leader>pd', '<Cmd>Lspsaga peek_definition<CR>', opts)
               vim.keymap.set('n', '<leader>fd', '<Cmd>Lspsaga goto_definition<CR>', opts)
               vim.keymap.set('n', '<leader>fD', '<Cmd>Lspsaga goto_type_definition<CR>', opts)
               vim.keymap.set('n', '<leader>fr', '<Cmd>Lspsaga finder<CR>', opts)
               vim.keymap.set('n', '<leader>fi', '<Cmd>Lspsaga subtypes<CR>', opts)
               vim.keymap.set('n', '<leader>fc', '<Cmd>Lspsaga incoming_calls<CR>', opts)
               vim.keymap.set('n', '<leader>fC', '<Cmd>Lspsaga outgoing_calls<CR>', opts)
               vim.keymap.set('n', '<leader>tt', '<Cmd>Lspsaga outline<CR>', opts)
               vim.keymap.set('n', ']g', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
               vim.keymap.set('n', '[g', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
               vim.keymap.set('n', '<leader>df', vim.lsp.buf.format, { buffer = args.buf })
               vim.keymap.set('v', '<leader>df', vim.lsp.buf.format, { buffer = args.buf })

               --end
            end,
         })
      end
   },
   {
      'hrsh7th/nvim-cmp',

      dependencies = {
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline',
         'quangnguyen30192/cmp-nvim-ultisnips',
         'SirVer/ultisnips'
      },
      config = function()
         local cmp = require("cmp")
         local cmp_autopairs = require('nvim-autopairs.completion.cmp')
         cmp.setup({
            snippet = {
               -- REQUIRED - you must specify a snippet engine
               expand = function(args)
                  vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
               end,
            },
            window = {
               -- completion = cmp.config.window.bordered(),
               -- documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
               ['<C-b>'] = cmp.mapping.scroll_docs(-4),
               ['<C-f>'] = cmp.mapping.scroll_docs(4),
               ['<C-Space>'] = cmp.mapping.complete(),
               ['<C-e>'] = cmp.mapping.abort(),
               ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'ultisnips' }, -- For ultisnips users.
               },
               {
                  { name = 'path' },
               },
               {
                  { name = 'buffer' },
               },
               {
                  { name = 'lazydev' },
                  group_index = 0
               }
            )
         })

         cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
         )

         cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
               { name = 'buffer' }
            }
         })

         -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
               { name = 'path' }
            }, {
               { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
         })
      end
   },
   {
      'SirVer/ultisnips',
      init = function()
         vim.g.UltiSnipsExpandTrigger = "<C-e>"
         vim.g.UltiSnipsSnippetDirectories = { '/home/ashwin/.vim/UltiSnipsPersonalSnippets' }
      end
   },
   {
      'ahmedkhalf/project.nvim',
      config = function()
         require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
         }
      end
   }

}
