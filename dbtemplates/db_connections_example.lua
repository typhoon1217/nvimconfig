-- Example database connections file
-- Copy this file to ~/.local/share/nvim/db_connections.lua and modify as needed
-- Or set environment variables for your database connections

return {
  -- SQLite (local file) - Great for getting started
  sqlite_local = {
    url = "sqlite:///" .. vim.fn.expand("~") .. "/test.db",
    description = "Local SQLite test database",
  },

  -- PostgreSQL connections
  postgres_dev = {
    url = "postgres://username:password@localhost:5432/myapp_development",
    description = "Development PostgreSQL database",
  },
  
  postgres_prod = {
    url = "postgres://username:password@prod-server:5432/myapp_production", 
    description = "Production PostgreSQL database",
  },

  -- MySQL connections
  mysql_local = {
    url = "mysql://root:password@localhost:3306/myapp",
    description = "Local MySQL database",
  },

  -- SQL Server
  sqlserver_dev = {
    url = "sqlserver://sa:YourPassword@localhost:1433/MyDatabase",
    description = "SQL Server development database",
  },

  -- MariaDB
  mariadb_local = {
    url = "mysql://root:password@localhost:3306/myapp",
    description = "Local MariaDB database",
  },

  -- Oracle (if you have Oracle DB)
  oracle_local = {
    url = "oracle://username:password@localhost:1521/ORCL",
    description = "Local Oracle database",
  },

  -- Redis (for key-value operations)
  redis_local = {
    url = "redis://localhost:6379/0",
    description = "Local Redis database",
  },
}

--[[
Environment variable examples (more secure approach):
Set these in your shell profile (.bashrc, .zshrc, etc.):

export DATABASE_URL="postgres://user:pass@localhost:5432/myapp"
export DEV_DATABASE_URL="postgres://user:pass@localhost:5432/myapp_dev"
export TEST_DATABASE_URL="postgres://user:pass@localhost:5432/myapp_test"

Then you don't need to hardcode credentials in this file.
--]]
