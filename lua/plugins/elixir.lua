return {
  -- Enable autotagging for Phoenix HEEx templates
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      per_filetype = {
        ["heex"] = { enable_close = true },
        ["elixir"] = { enable_close = true },
      },
    },
  },

  -- Projectionist for switching between Phoenix LiveView <-> Template <-> Test <-> SCSS
  {
    "tpope/vim-projectionist",
    event = "BufReadPre",
    init = function()
      vim.g.projectionist_heuristics = {
        ["mix.exs"] = {
          -- LiveView to HEEx template
          ["lib/**/*_live.ex"] = {
            ["type"] = "liveview",
            ["alternate"] = "lib/{dirname}/{basename}_live.html.heex",
          },
          ["lib/**/*_live.html.heex"] = {
            ["type"] = "template",
            ["alternate"] = "lib/{dirname}/{basename}_live.ex",
          },
          -- Component to SCSS styles (if component-scoped SCSS in assets/css/components/)
          ["lib/**/*_component.ex"] = {
            ["type"] = "component",
            ["alternate"] = "assets/css/components/{basename}.scss",
          },
          -- Elixir source to ExUnit test
          ["lib/*.ex"] = {
            ["type"] = "source",
            ["alternate"] = "test/{}_test.exs",
          },
          ["test/*_test.exs"] = {
            ["type"] = "test",
            ["alternate"] = "lib/{}.ex",
          },
        },
      }
    end,
    keys = {
      { "<leader>fa", "<cmd>A<cr>", desc = "Alternate File (LiveView / Template / Test)" },
      { "<leader>av", "<cmd>AV<cr>", desc = "Alternate File (V-Split)" },
    },
  },
}
