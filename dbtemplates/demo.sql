-- Demo SQL file for testing vim-dadbod integration
-- Use this file to test your database connections

-- Create a simple table (SQLite example)
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO users (username, email) VALUES 
    ('john_doe', 'john@example.com'),
    ('jane_smith', 'jane@example.com'),
    ('bob_wilson', 'bob@example.com');

-- Query examples
SELECT * FROM users;

SELECT username, email FROM users WHERE created_at > '2024-01-01';

-- Count users
SELECT COUNT(*) as user_count FROM users;

-- Update example
UPDATE users SET email = 'newemail@example.com' WHERE username = 'john_doe';

-- Join example (if you have multiple tables)
-- SELECT u.username, p.title 
-- FROM users u 
-- JOIN posts p ON u.id = p.user_id;

/*
How to use this file:
1. Open this file in Neovim: :edit demo.sql
2. Position cursor on a SQL statement
3. Press <leader>ds to execute the statement under cursor
4. Or select text in visual mode and press <leader>ds
5. Or use :DB <connection_name> to execute

Available commands:
- :DBUI                    - Open the database UI
- :DBUIToggle             - Toggle database UI (<leader>du)
- :DBUIFindBuffer         - Find database buffer (<leader>df)
- :DBUIAddConnection      - Add new connection
- <leader>da              - Add connection interactively
*/