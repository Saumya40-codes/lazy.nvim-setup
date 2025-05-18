-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "live grep" })
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dbg", function()
  require("dap-go").debug_test()
end)

-- for java

vim.keymap.set("n", "<leader>rj", function()
  local file = vim.fn.expand("%:t:r")
  local compile_cmd = "javac " .. file .. ".java"
  local run_cmd = "java " .. file

  -- open a terminal and run the command
  vim.cmd("TermExec cmd='" .. compile_cmd .. " && " .. run_cmd .. "'")
end, { desc = "Run Java File" })
