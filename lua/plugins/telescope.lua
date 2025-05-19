return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "go.sum",
          "%.lock", -- ignores yarn.lock, package-lock.json etc.
          "%.min%.js", -- ignores minified JS files
        },
      },
    })

    vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
  end,
}
