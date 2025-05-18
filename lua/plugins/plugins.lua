return {
  { "wakatime/vim-wakatime", lazy = false },
  -- {  uncomment if copilot is needed :)
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<Tab>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --         filter_disallow = {
  --           -- Disable suggestions in comments
  --           [1] = function(suggestion)
  --             local context = suggestion.context
  --             return context.filetype == "comment"
  --           end,
  --         },
  --       },
  --       panel = { enabled = false },
  --       filetypes = {
  --         ["*"] = true,
  --       },
  --     })
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          telescope = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
        },
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      require("dap-go").setup()
    end,
  },
}
