local M = {}

M.export_as_md = function ()
   local cmd = string.format("Neorg export to-file %s.md", vim.fn.fnameescape(vim.fn.expand("%:p:r")))
   vim.fn.execute(cmd, 'silent!')
end

return M
