return {
  -- The LazyVim java extra in lazyvim.json drives jdtls via nvim-jdtls.
  -- We just add settings on top of it here.
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "mason.nvim" },
    opts = function(_, opts)
      opts.jvm_args = opts.jvm_args or {}

      local lombok_jar = vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/1.18.36/lombok-1.18.36.jar")
      if vim.fn.filereadable(lombok_jar) == 1 then
        table.insert(opts.jvm_args, "-javaagent:" .. lombok_jar)
      end

      -- Heap + GC: default heap OOMs on Fabric/Minecraft sources and corrupts the JDT index.
      vim.list_extend(opts.jvm_args, {
        "-Xms1g",
        "-Xmx4g",
        "-XX:+UseG1GC",
        "-XX:+UseStringDeduplication",
      })

      -- Discover installed JDKs via /usr/libexec/java_home so we don't hardcode brittle paths.
      local function detect_runtimes()
        local runtimes = {}
        local seen = {}
        local out = vim.fn.system({ "/usr/libexec/java_home", "-V" })
        for line in out:gmatch("[^\r\n]+") do
          local version, path = line:match('^%s*(%d+)[%d%.]*.-"%s*(/[^"]+)%s*$')
          if version and path and not seen[version] then
            seen[version] = true
            local v = tonumber(version)
            if v and v >= 17 then
              table.insert(runtimes, {
                name = "JavaSE-" .. version,
                path = path,
              })
            end
          end
        end
        table.sort(runtimes, function(a, b)
          return a.name < b.name
        end)
        if #runtimes > 0 then
          runtimes[#runtimes].default = true
        end
        return runtimes
      end

      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          saveActions = {
            organizeImports = false,
            cleanup = false,
          },
          completion = {
            importOrder = { "java", "javax", "jakarta", "org", "com", "" },
          },
          -- Reduce memory pressure during initial index build.
          maxConcurrentBuilds = 1,
          -- Stop the noisy 404 loop on snapshot wrapper checksums.
          import = {
            gradle = {
              wrapper = {
                enabled = true,
                checksums = {},
              },
            },
          },
          configuration = {
            runtimes = detect_runtimes(),
          },
        },
      })
      return opts
    end,
  },

  -- Keep jdtls out of mason-lspconfig's ensure_installed list
  -- (nvim-jdtls starts it directly; lspconfig must not duplicate it)
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = vim.tbl_filter(function(server)
        return server ~= "jdtls"
      end, opts.ensure_installed)
      return opts
    end,
  },
}
