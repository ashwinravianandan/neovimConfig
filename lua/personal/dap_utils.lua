local M = {}

M.pick_process_id = function()
   local daputils = require("dap.utils")
   return daputils.pick_process()
end

return M
