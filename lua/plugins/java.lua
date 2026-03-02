return {
  -- Explicitly disable Java extra to prevent conflicts
  { import = "lazyvim.plugins.extras.lang.java", enabled = false },
  
  -- Disable DAP extras that might be auto-loading
  { import = "lazyvim.plugins.extras.dap.core", enabled = false },
  
  -- Disable nvim-dap to prevent setup errors
  { "mfussenegger/nvim-dap", enabled = false },
  
  -- Override mason-lspconfig to prevent jdtls
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Remove jdtls from ensure_installed if present
      opts.ensure_installed = vim.tbl_filter(function(server)
        return server ~= "jdtls"
      end, opts.ensure_installed)
      return opts
    end,
  },
  
  "nvim-java/nvim-java",
  config = function()
    require("java").setup({
      notifications = {
        dap_failed = { enabled = false },
      },
    })
  end,
}
