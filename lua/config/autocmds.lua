-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    -- Re-run the detection logic here
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
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("TiltfileDetection", { clear = true }),
  pattern = { "Tiltfile", "Tiltfile.*" },
  callback = function()
    vim.bo.filetype = "tiltfile"
  end,
})
