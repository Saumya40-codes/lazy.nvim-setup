return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      go = "go",
      goimports = "gopls",
      fillstruct = "gopls",
      gofmt = "gofumpt",
      tag_transform = false,
      test_template = "",
      test_template_dir = "",
      comment_placeholder = "",
      lsp_gofumpt = true,
    })

    vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { silent = true, desc = "Go Test" })
    vim.keymap.set("n", "<leader>gi", "<cmd>GoImports<CR>", { silent = true, desc = "Go Imports" })
    vim.keymap.set("n", "<leader>gf", "<cmd>GoFormat<CR>", { silent = true, desc = "Go Format" })
    vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<CR>", { silent = true, desc = "Go Run" })

    -- hook gopls settings via nvim-lspconfig
    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
        },
      },
    })
  end,
}
