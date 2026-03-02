-- Fix for LSP registration issues
local original_register_capability = vim.lsp.handlers["client/registerCapability"]

vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
  -- Ensure registrations is a table
  if res and res.registrations == nil then
    res.registrations = {}
  end
  return original_register_capability(err, res, ctx)
end