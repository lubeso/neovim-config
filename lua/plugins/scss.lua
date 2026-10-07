return {
  -- 1. LSP Configuration for SCSS, CSS, and CSS Modules
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- General CSS/SCSS language server
        cssls = {
          filetypes = { "css", "scss", "less" },
          settings = {
            css = { validate = true },
            scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          },
        },

        -- Specialized Sass language server (@use, @forward, mixins, variables, SassDoc)
        somesass_ls = {
          filetypes = { "scss", "sass" },
        },

        -- CSS Modules intelligence for React: jump to definition from TSX into .module.scss
        cssmodules_ls = {
          filetypes = { "javascriptreact", "typescriptreact" },
          init_options = {
            camelCase = true,
          },
        },
      },
    },
  },

  -- 2. Stylelint via nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        scss = { "stylelint" },
        sass = { "stylelint" },
      },
    },
  },

  -- 3. Prettier configuration via conform.nvim for formatting SCSS/CSS
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        scss = { "prettier" },
        sass = { "prettier" },
        css = { "prettier" },
      },
    },
  },

  -- 4. Mason: ensure all SCSS language servers & linters are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "some-sass-language-server",
        "cssmodules-language-server",
        "stylelint",
      })
    end,
  },
}
