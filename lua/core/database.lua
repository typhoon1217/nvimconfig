-- Database connection management for vim-dadbod
local M = {}

-- Common database connection examples
M.connections = {
  -- SQLite example (local file)
  sqlite_example = {
    url = "sqlite:///path/to/your/database.db",
    description = "Local SQLite database",
  },
  
  -- PostgreSQL examples
  postgres_local = {
    url = "postgres://username:password@localhost:5432/database_name",
    description = "Local PostgreSQL database",
  },
  
  postgres_remote = {
    url = "postgres://username:password@remote-host:5432/database_name",
    description = "Remote PostgreSQL database",
  },
  
  -- MySQL examples  
  mysql_local = {
    url = "mysql://username:password@localhost:3306/database_name",
    description = "Local MySQL database",
  },
  
  -- SQL Server example
  sqlserver = {
    url = "sqlserver://username:password@localhost:1433/database_name",
    description = "SQL Server database",
  },
  
  -- Oracle example
  oracle = {
    url = "oracle://username:password@localhost:1521/database_name",
    description = "Oracle database",
  },
}

-- Function to set up environment variables for database connections
-- This is more secure than hardcoding credentials
M.setup_env_connections = function()
  -- Example: Set up connections using environment variables
  local connections = {}
  
  -- PostgreSQL from environment
  if vim.env.DATABASE_URL then
    connections["main"] = {
      url = vim.env.DATABASE_URL,
      description = "Main database from env",
    }
  end
  
  -- Development database
  if vim.env.DEV_DATABASE_URL then
    connections["dev"] = {
      url = vim.env.DEV_DATABASE_URL,
      description = "Development database",
    }
  end
  
  -- Test database
  if vim.env.TEST_DATABASE_URL then
    connections["test"] = {
      url = vim.env.TEST_DATABASE_URL,
      description = "Test database",
    }
  end
  
  -- Set global variable for vim-dadbod-ui
  if next(connections) then
    vim.g.dbs = connections
  end
end

-- Function to add a new connection interactively
M.add_connection = function()
  local name = vim.fn.input("Connection name: ")
  if name == "" then return end
  
  local url = vim.fn.input("Database URL: ")
  if url == "" then return end
  
  local description = vim.fn.input("Description (optional): ")
  
  -- Initialize dbs if it doesn't exist
  if not vim.g.dbs then
    vim.g.dbs = {}
  end
  
  vim.g.dbs[name] = {
    url = url,
    description = description ~= "" and description or name,
  }
  
  vim.notify("Added connection: " .. name, vim.log.levels.INFO)
end

-- Function to load connections from a config file
M.load_connections_from_file = function(file_path)
  local ok, connections = pcall(dofile, file_path)
  if ok and type(connections) == "table" then
    -- Merge with existing connections if any
    if not vim.g.dbs then
      vim.g.dbs = {}
    end
    for name, url in pairs(connections) do
      vim.g.dbs[name] = url
    end
    vim.notify("Loaded database connections from " .. file_path, vim.log.levels.INFO)
  else
    vim.notify("Failed to load connections from " .. file_path, vim.log.levels.ERROR)
  end
end

-- Initialize database connections
M.setup = function()
  -- Initialize the global dbs table
  vim.g.dbs = {}
  
  -- Try to load from environment variables first
  M.setup_env_connections()
  
  -- Try to load from project-specific config file first
  local project_config = vim.fn.getcwd() .. "/db_connections.lua"
  if vim.fn.filereadable(project_config) == 1 then
    M.load_connections_from_file(project_config)
  else
    -- Fallback to user config file
    local config_file = vim.fn.stdpath("data") .. "/db_connections.lua"
    if vim.fn.filereadable(config_file) == 1 then
      M.load_connections_from_file(config_file)
    end
  end
  
  -- Debug: show what connections were loaded
  if vim.g.dbs and next(vim.g.dbs) then
    local count = 0
    for _ in pairs(vim.g.dbs) do count = count + 1 end
    vim.notify("Loaded " .. count .. " database connections", vim.log.levels.INFO)
  end
end

return M