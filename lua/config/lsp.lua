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
        return -- Skip jdtls; nvim-jdtls / LazyVim java extra handles it
      end
      if server_name == "java_language_server" then
        return -- Skip georgewfraser's java-language-server; it forces organize-imports on save
      end
      require("lspconfig")[server_name].setup({})
    end,
  },
})

