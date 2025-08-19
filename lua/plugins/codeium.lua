---@type NvPluginSpec
-- NOTE: AI Autocomplete
return {
  "Exafunction/codeium.nvim",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  opts = {
    enable_chat = true,
  },
  config = function(_, opts)
    require("codeium").setup(opts)
    
    -- Keymaps similar to supermaven
    vim.keymap.set("i", "<A-f>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
    
    vim.keymap.set("i", "<A-w>", function()
      return vim.fn["codeium#AcceptNextWord"]()
    end, { expr = true, silent = true, desc = "Accept Codeium word" })
    
    vim.keymap.set("i", "<A-n>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
    
    vim.keymap.set("i", "<A-p>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
    
    vim.keymap.set("i", "<A-c>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })
  end,
}