return {
  -- LSP Configuration: Pyright & Ruff tuned for modern pyproject.toml projects
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "none",
                  reportUnusedVariable = "none",
                },
              },
            },
          },
        },
      },
      setup = {
        ruff = function()
          LazyVim.lsp.on_attach(function(client)
            if client.name == "ruff" then
              -- Disable hover in favor of Pyright's richer type/docstring hover
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },

  -- Formatting: Ruff fix and format on save via Conform
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
    },
  },

  -- Virtual Environment selector: discover and switch venvs (.venv, uv, poetry, pdm)
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      options = {
        notify_user_on_venv_activation = true,
        cached_venv_automatic_activation = true,
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" },
    },
  },

  -- Alternate file navigation: pyproject.toml source <-> test mappings
  {
    "tpope/vim-projectionist",
    event = "BufReadPre",
    init = function()
      local heuristics = vim.g.projectionist_heuristics or {}
      heuristics["pyproject.toml"] = {
        -- src layout (recommended standard)
        ["src/**/*.py"] = {
          ["type"] = "source",
          ["alternate"] = "tests/{dirname}/test_{basename}.py",
        },
        ["tests/**/test_*.py"] = {
          ["type"] = "test",
          ["alternate"] = "src/{dirname}/{basename}.py",
        },
        -- Flat layout
        ["*.py"] = {
          ["type"] = "source",
          ["alternate"] = "tests/test_{basename}.py",
        },
        ["tests/test_*.py"] = {
          ["type"] = "test",
          ["alternate"] = "{basename}.py",
        },
      }
      vim.g.projectionist_heuristics = heuristics
    end,
  },
}
