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
      -- Setting this to nil or empty ensures base16 takes over
      colorscheme = function() end,
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tilt_ls = {},
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "starlark",
        "tsx",
        "typescript",
      })
    end,
    config = function()
      vim.treesitter.language.register("starlark", "tiltfile")
    end,
  },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "flake8",
        "stylua",
        "shellcheck",
        "shfmt",
        "tilt",
      },
    },
  },
}
