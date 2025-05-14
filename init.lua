local vimrc = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd.source(vimrc)

require("config.lazy")

local keymaps = vim.fn.stdpath("config") .. "/keymaps.vim"
vim.cmd.source(keymaps)

local autocmds = vim.fn.stdpath("config") .. "/autocmds.vim"
vim.cmd.source(autocmds)
