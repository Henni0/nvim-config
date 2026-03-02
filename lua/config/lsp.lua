-- lsp.lua

-- make sure mason and mason-lspconfig are loaded
require("mason").setup({
  ui = {
    icons = {
      package_installed = "◍",
      package_pending = "◐",
      package_uninstalled = "◯",
    },
  },
  -- Don't auto-install jdtls
  automatic_installation = {
    exclude = { "jdtls" },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "dartls" },
  -- Completely disable automatic installation to prevent conflicts
  automatic_installation = false,
  -- Setup handler for all installed servers except jdtls
  handlers = {
    function(server_name)
      if server_name == "jdtls" then
        return -- Skip jdtls completely, nvim-java handles it
      end
      require("lspconfig")[server_name].setup({})
    end,
  },
})

-- Override the install function to completely prevent jdtls installation
local mason_registry = require("mason-registry")
local original_get_package = mason_registry.get_package
mason_registry.get_package = function(name)
  if name == "jdtls" then
    error("jdtls installation is blocked - use nvim-java instead")
  end
  return original_get_package(name)
end
