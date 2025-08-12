return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree | Toggle Undo Tree", silent = true },
  },
  config = function()
    -- Set undotree window width
    vim.g.undotree_SplitWidth = 30
    
    -- Set undotree window to open on the right
    vim.g.undotree_WindowLayout = 2
    
    -- Focus on undotree after toggle
    vim.g.undotree_SetFocusWhenToggle = 1
    
    -- Show diff in undotree
    vim.g.undotree_DiffpanelHeight = 10
    
    -- Enable timestamps
    vim.g.undotree_RelativeTimestamp = 1
    
    -- Short indicators
    vim.g.undotree_ShortIndicators = 1
  end,
}