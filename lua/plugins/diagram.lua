return {
  "3rd/diagram.nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  event = "VeryLazy",
  config = function()
    local diagram = require("diagram")
    local renderers = require("diagram.renderers")
    
    -- Custom integration for .mermaid files with proper structure
    local mermaid_integration = {
      id = "mermaid_files",
      filetypes = { "mermaid" },
      renderers = {
        renderers.mermaid,
      },
      query_buffer_diagrams = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        local filename = vim.api.nvim_buf_get_name(bufnr)
        
        -- Only process .mermaid files
        if filetype ~= "mermaid" and not filename:match("%.mermaid$") then
          return {}
        end
        
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local content = table.concat(lines, "\n")
        
        -- Return diagram in the expected format
        return {
          {
            bufnr = bufnr,
            renderer_id = "mermaid",
            source = content,
            range = {
              start_row = 0,
              start_col = 0,
              end_row = #lines - 1,
              end_col = 0,
            },
          },
        }
      end,
    }
    
    -- Build integrations list safely
    local integrations = {}
    
    -- Try to load markdown integration
    local ok_md, markdown_integration = pcall(require, "diagram.integrations.markdown")
    if ok_md then
      table.insert(integrations, markdown_integration)
    end
    
    -- Try to load neorg integration
    local ok_neorg, neorg_integration = pcall(require, "diagram.integrations.neorg")
    if ok_neorg then
      table.insert(integrations, neorg_integration)
    end
    
    -- Add custom mermaid integration
    table.insert(integrations, mermaid_integration)
    
    -- Setup diagram with available integrations
    diagram.setup({
      integrations = integrations,
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
          scale = 2, -- Increased scale for better readability
          width = 1200, -- Set minimum width
          height = 800, -- Set minimum height
        },
        plantuml = {
          charset = nil,
        },
        d2 = {
          theme_id = nil,
          dark_theme_id = nil,
          scale = nil,
          layout = nil,
          sketch = nil,
        },
      },
    })
  end,
}
