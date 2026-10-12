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

-- Organize Imports (TypeScript/React & Python)
map("n", "<leader>co", function()
  local ft = vim.bo.filetype
  if ft == "typescript" or ft == "typescriptreact" then
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports.ts" },
        diagnostics = {},
      },
    })
  elseif ft == "python" then
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports" },
        diagnostics = {},
      },
    })
  end
end, { desc = "Organize Imports" })

-- Alternate File toggle (works with vim-projectionist)
map("n", "<leader>fa", "<cmd>A<cr>", { desc = "Alternate File (Source <-> Test)" })
