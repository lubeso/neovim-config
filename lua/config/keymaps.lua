-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Test Runner Shortcuts (neotest for Vitest / mix test)
map("n", "<leader>tt", function()
  require("neotest").run.run()
end, { desc = "Run Nearest Test" })

map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run Current Test File" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Test Summary" })

map("n", "<leader>to", function()
  require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Show Test Output" })

map("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Stop Running Test" })

-- TypeScript / React: Organize Imports
map("n", "<leader>co", function()
  if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports.ts" },
        diagnostics = {},
      },
    })
  end
end, { desc = "Organize Imports (TS/React)" })

-- Quick Alternate File toggle (works with vim-projectionist)
map("n", "<leader>a", "<cmd>A<cr>", { desc = "Toggle Alternate File (LiveView <-> Template <-> Test)" })
