---@type NvPluginSpec
return {
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 40
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/db_ui"
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_use_nvim_notify = 1
      
      -- Key mappings
      vim.keymap.set("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "Database | Toggle DBUI" })
      vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Database | Find Buffer" })
      vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Database | Rename Buffer" })
      vim.keymap.set("n", "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", { desc = "Database | Last Query Info" })
    end,
    config = function()
      -- Auto-completion setup for SQL files
      require("cmp").setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
          { name = "luasnip" },
        },
      })
      
      -- Additional keymaps for SQL buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function()
          vim.keymap.set("v", "<leader>ds", "<cmd>DB<cr>", { desc = "Database | Execute Selection", buffer = true })
          vim.keymap.set("n", "<leader>ds", "vip<cmd>DB<cr>", { desc = "Database | Execute Paragraph", buffer = true })
        end,
      })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "sql", "mysql", "plsql" },
    lazy = true,
  },
}
