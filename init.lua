local vimrc = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd.source(vimrc)


  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
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

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
  }

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
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

--require'lspconfig'.clangd.setup{}

vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(args)
      local opts = {noremap =true, silent=true}
      --local client = vim.lsp.get_client_by_id(args.data.client_id)
      --if client.server_capabilities.hoverProvider then
         vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
         vim.keymap.set('n', 'yd', vim.lsp.buf.definition, { buffer = args.buf })
         vim.keymap.set('n', 'yD', vim.lsp.buf.declaration, { buffer = args.buf })
         vim.keymap.set('n', 'yr', vim.lsp.buf.references, { buffer = args.buf })
         vim.keymap.set('n', 'yi', vim.lsp.buf.implementation, { buffer = args.buf })
         vim.keymap.set('n', 'yc', vim.lsp.buf.incoming_calls, { buffer = args.buf })
         vim.keymap.set('n', 'yC', vim.lsp.buf.outgoing_calls, { buffer = args.buf })
         vim.keymap.set('n', 'ya', vim.lsp.buf.code_action, { buffer = args.buf })
         vim.keymap.set('n', 'pd', '<Cmd>Lspsaga peek_definition<CR>', opts )
         vim.keymap.set('n', 'sf', '<Cmd>Lspsaga finder<CR>', opts )
      --end
   end,
})

require('lspsaga').setup({
    -- Your configuration options here
     })
