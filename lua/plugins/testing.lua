return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "jfpedroza/neotest-elixir",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("neotest-elixir"),
        require("neotest-vitest"),
        require("neotest-python")({
          runner = "pytest",
          python = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            end
            return "python3"
          end,
          pytest_discover_instances = true,
        }),
      })
    end,
  },
}
