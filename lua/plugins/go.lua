return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      go = "go",
      goimports = "gopls",
      fillstruct = "gopls",
      gofmt = "gofumpt",
      tag_transform = false,
      -- lang.go extra starts gopls via LazyVim/mason; keep go.nvim LSP off to avoid double gopls
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_inlay_hints = { enable = true },
      -- go.nvim master calls vim.lsp.codelens.enable() which does NOT exist on Neovim 0.11
      -- (only refresh/clear/run/...). That throws on every BufRead/InsertLeave for *.go.
      -- Disable go.nvim's codelens; we refresh safely ourselves below when on 0.11.
      lsp_codelens = false,
      dap_debug = true,
      -- LazyVim dap.core owns UI + keymaps; do not let go.nvim install temporary single-key maps
      dap_debug_gui = false,
      dap_debug_keymap = false,
      trouble = true,
      luasnip = false, -- stack uses blink.cmp, not LuaSnip
    },
    config = function(_, opts)
      require("go").setup(opts)

      -- Safe codelens for Neovim 0.11 (go.nvim uses enable() which is 0.12+)
      if vim.lsp.codelens and type(vim.lsp.codelens.refresh) == "function" and type(vim.lsp.codelens.enable) ~= "function" then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "BufWritePost" }, {
          group = vim.api.nvim_create_augroup("GoCodeLensNvim011", { clear = true }),
          pattern = { "*.go", "go.mod" },
          callback = function(ev)
            local clients = vim.lsp.get_clients({ bufnr = ev.buf, name = "gopls" })
            if #clients > 0 then
              pcall(vim.lsp.codelens.refresh, { bufnr = ev.buf })
            end
          end,
        })
      end

      -- Buffer-local maps under <leader>go* so we never shadow LazyVim git keys
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod" },
        group = vim.api.nvim_create_augroup("GoNvimMaps", { clear = true }),
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end
          map("<leader>got", "<cmd>GoTest<CR>", "Go Test")
          map("<leader>goT", "<cmd>GoTestFunc<CR>", "Go Test Func")
          map("<leader>goi", "<cmd>GoImports<CR>", "Go Imports")
          map("<leader>gof", "<cmd>GoFormat<CR>", "Go Format")
          map("<leader>gor", "<cmd>GoRun<CR>", "Go Run")
          map("<leader>goc", "<cmd>GoCoverage<CR>", "Go Coverage")
          map("<leader>goe", "<cmd>GoIfErr<CR>", "Go If Err")
        end,
      })
    end,
  },
}
