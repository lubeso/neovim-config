local agy_bin = vim.fn.exepath("agy")
if agy_bin == "" and vim.fn.executable(vim.fn.expand("~/.local/bin/agy")) == 1 then
  agy_bin = vim.fn.expand("~/.local/bin/agy")
end
if agy_bin == "" then
  agy_bin = "agy"
end

local function toggle_agy(opts)
  opts = opts or {}
  local cmd = { agy_bin }
  if opts.args then
    vim.list_extend(cmd, opts.args)
  end

  Snacks.terminal(cmd, {
    cwd = LazyVim.root(),
    win = opts.win or {
      position = "float",
      width = 0.85,
      height = 0.85,
      border = "rounded",
    },
  })
end

return {
  -- Register Antigravity keymap group in which-key
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "antigravity", icon = "󰚩 " },
      },
    },
  },

  -- Antigravity terminal launchers via Snacks.terminal
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>aa",
        function()
          toggle_agy({
            win = {
              position = "float",
              width = 0.85,
              height = 0.85,
              border = "rounded",
            },
          })
        end,
        desc = "Toggle Antigravity (Float)",
      },
      {
        "<leader>as",
        function()
          toggle_agy({
            win = {
              position = "right",
              width = 0.42,
            },
          })
        end,
        desc = "Antigravity Side Split",
      },
      {
        "<leader>ab",
        function()
          toggle_agy({
            win = {
              position = "bottom",
              height = 0.4,
            },
          })
        end,
        desc = "Antigravity Bottom Split",
      },
      {
        "<leader>ac",
        function()
          toggle_agy({ args = { "--continue" } })
        end,
        desc = "Continue / Resume Session",
      },
      {
        "<leader>ap",
        function()
          toggle_agy({ args = { "--mode", "plan" } })
        end,
        desc = "Plan Mode",
      },
      {
        "<leader>af",
        function()
          local file = vim.fn.expand("%:p")
          if file == "" then
            LazyVim.warn("No active file to send to Antigravity")
            return
          end
          toggle_agy({
            args = { "-i", string.format("Review and assist with %s", file) },
          })
        end,
        desc = "Review Current File",
      },
      {
        "<leader>aR",
        function()
          local root = LazyVim.root()
          local rules_file = root .. "/AGENTS.md"
          vim.cmd("edit " .. vim.fn.fnameescape(rules_file))
        end,
        desc = "Edit Workspace Rules (AGENTS.md)",
      },
      {
        "<leader>a",
        function()
          local start_pos = vim.fn.getpos("'<")
          local end_pos = vim.fn.getpos("'>")
          local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
          local code_snippet = table.concat(lines, "\n")

          vim.ui.input({ prompt = "Antigravity Prompt: " }, function(input)
            if not input or input == "" then
              return
            end
            local prompt = string.format("%s\n\n```%s\n%s\n```", input, vim.bo.filetype, code_snippet)
            toggle_agy({ args = { "-i", prompt } })
          end)
        end,
        mode = "v",
        desc = "Ask Antigravity About Selection",
      },
    },
  },
}
