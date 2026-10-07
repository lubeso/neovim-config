return {
  -- Add and configure the base16 plugin
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Set background and colorscheme based on system
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      if handle ~= nil then
        local result = handle:read("*a")
        if result:find("Dark") then
          vim.o.background = "dark"
          vim.cmd("colorscheme base16-grayscale-dark")
        else
          vim.o.background = "light"
          vim.cmd("colorscheme base16-grayscale-light")
        end
        handle:close()
      end
    end,
  },

  -- Configure LazyVim to use the colorscheme we just set
  {
    "LazyVim/LazyVim",
    opts = {
      -- Setting this to empty ensures base16 takes over
      colorscheme = function() end,
    },
  },

  -- Tiltfile LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tilt_ls = {},
      },
    },
  },

  -- Treesitter: ensure required parsers are installed without overriding setup config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "starlark",
        "tsx",
        "typescript",
        "javascript",
        "html",
        "css",
        "scss",
        "elixir",
        "heex",
        "eex",
      })
    end,
    init = function()
      vim.treesitter.language.register("starlark", "tiltfile")
    end,
  },

  -- Base developer tools installed via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "tilt",
      })
    end,
  },
}
