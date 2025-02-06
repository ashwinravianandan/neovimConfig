--- LSP related plugins

return{
	{'nvimdev/lspsaga.nvim', opts={}},
	{'neovim/nvim-lspconfig', 
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
				vim.keymap.set('n', '<leader>o', '<Cmd>Lspsaga outline<CR>', opts)
				vim.keymap.set('n', '<leader>df', vim.lsp.buf.format, { buffer = args.buf })

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
				{ name = 'ultisnips' },  -- For ultisnips users.
			}, {
				{ name = 'buffer' },
			})
		})

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
{'SirVer/ultisnips', init = function()
	vim.g.UltiSnipsExpandTrigger="<C-e>"
	vim.g.UltiSnipsSnippetDirectories={ '/home/ashwin/.vim/UltiSnipsPersonalSnippets'}
end
}
}

