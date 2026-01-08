require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>qa", "<cmd> qa <cr>", { desc = "General Quit all" })
map("n", "<leader>qw", "<cmd> wqa <cr>", { desc = "Quit all and save" })
-- 1. JAVA SOURCE ACTIONS (Organize, Sort, Override)
map("n", "<leader>jo", function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, { desc = "Java: Organize Imports" })

map("n", "<leader>js", function()
  vim.lsp.buf.code_action({ context = { only = { "source.sortMembers" } }, apply = true })
end, { desc = "Java: Sort Members" })

map("n", "<leader>jv", function()
  vim.lsp.buf.code_action({ context = { only = { "source.overrideMethods" } }, apply = true })
end, { desc = "Java: Override Methods" })

-- 2. JAVA GENERATION (Constructors, Getters/Setters)
map("n", "<leader>jc", function()
  vim.lsp.buf.code_action({ context = { only = { "source.generate.constructors" } }, apply = true })
end, { desc = "Java: Generate Constructors" })

map("n", "<leader>jg", function()
  vim.lsp.buf.code_action({ context = { only = { "source.generate.accessors" } }, apply = true })
end, { desc = "Java: Generate Getters/Setters" })

map("n", "<leader>jh", function()
  vim.lsp.buf.code_action({ context = { only = { "source.generate.hashCodeEquals" } }, apply = true })
end, { desc = "Java: Generate HashCode & Equals" })

map("n", "<leader>jt", function()
  vim.lsp.buf.code_action({ context = { only = { "source.generate.toString" } }, apply = true })
end, { desc = "Java: Generate toString" })

-- 3. JAVA REFACTORING (Extracting & Assigning)
-- These work best in Visual Mode ("v") for extracting code blocks
map({ "n", "v" }, "<leader>jre", function()
  vim.lsp.buf.code_action({ context = { only = { "refactor.extract.function" } }, apply = true })
end, { desc = "Java: Extract Method/Function" })

map({ "n", "v" }, "<leader>jrv", function()
  vim.lsp.buf.code_action({ context = { only = { "refactor.extract.variable" } }, apply = true })
end, { desc = "Java: Extract Variable" })

map({ "n", "v" }, "<leader>jrc", function()
  vim.lsp.buf.code_action({ context = { only = { "refactor.extract.constant" } }, apply = true })
end, { desc = "Java: Extract Constant" })

map("n", "<leader>jrm", function()
  vim.lsp.buf.code_action({ context = { only = { "refactor.move" } }, apply = true })
end, { desc = "Java: Move" })

