---@type NvPluginSpec
return {
  "brianhuster/live-preview.nvim",
  opts = {},
  keys = {
    {
      "<leader>lp",
      "<cmd>LivePreview start<cr>",
      desc = "Start Live Preview",
    },
    {
      "<leader>lc",
      "<cmd>LivePreview close<cr>",
      desc = "Close Live Preview",
    },
  },
  ft = { "html", "markdown", "asciidoc", "svg" },
}