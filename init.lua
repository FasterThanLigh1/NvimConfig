--------------------------------------------------------------------------------
-- 1 qa. SET LEADER KEYS (Must be defined before plugins/mappings)
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- 2. BOOTSTRAP MINI.DEPS
--------------------------------------------------------------------------------
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing mini.deps..."')
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.deps', mini_path
  })
  vim.cmd('packadd mini.deps')
  vim.cmd('echo "mini.deps installed!"')
end

-- Initialize mini.deps
require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add

--------------------------------------------------------------------------------
-- 3. SENSIBLE NEOVIM OPTIONS
--------------------------------------------------------------------------------
local opt = vim.opt

opt.number = true          -- Turn on line numbers
opt.relativenumber = false -- Static line numbers (1 to ...)
opt.splitright = true      
opt.splitbelow = true      
opt.expandtab = true       
opt.shiftwidth = 4         
opt.tabstop = 4            
opt.smartindent = true     
opt.ignorecase = true      
opt.smartcase = true       
opt.termguicolors = true   
opt.signcolumn = "yes"     
opt.clipboard = "unnamedplus"

--------------------------------------------------------------------------------
-- 4. THEME & VISUAL CUSTOMIZATION (Gruvbox + Ultra-Light Comments)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#504945", italic = false, bold = false })
  end,
})

add({ source = 'ellisonleao/gruvbox.nvim' })
vim.o.background = "dark"

local has_gruvbox, gruvbox = pcall(require, "gruvbox")
if has_gruvbox then
  gruvbox.setup({
    italic = { comments = false, strings = false },
    contrast = "hard",
  })
  vim.cmd("colorscheme gruvbox")
end

--------------------------------------------------------------------------------
-- 5. THE MINI ECOSYSTEM
--------------------------------------------------------------------------------
add({ source = 'echasnovski/mini.nvim' })

local has_mini = pcall(require, 'mini.files')

if has_mini then
  -- Mini.icons (Set this up first so other modules can use it for filetypes)
  require('mini.icons').setup()

  -- Mini.files (File Explorer)
  require('mini.files').setup()

  -- Mini.statusline (Minimal statusline at the bottom)
  require('mini.statusline').setup()

  -- Mini.tabline (Minimal tab/buffer line at the top)
  require('mini.tabline').setup()

  -- Mini.ai (Enhanced text objects)
  require('mini.ai').setup()

  -- Mini.pairs (Auto-pairs brackets/quotes)
  require('mini.pairs').setup()

  -- Mini.bracketed (Navigate via brackets [b, ]b, etc.)
  require('mini.bracketed').setup()

  -- Mini.visits (Track recent/frequent files)
  require('mini.visits').setup()

  -- Mini.indentscope (Vertical lines for code blocks)
  require('mini.indentscope').setup({ symbol = "│" })

  -- Mini.notify (Intercepts notifications into popup cards)
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()

  -- Mini.starter (Dashboard splash screen)
  require('mini.starter').setup()

  -- Mini.trailspace (Highlights trailing spaces)
  require('mini.trailspace').setup()

  -- Mini.animate (Smooth UI animations for scroll/cursor/resize)
  require('mini.animate').setup()

  -- Mini.cursorword (Automatically underlines matching instances of current word)
  require('mini.cursorword').setup()

  -- Mini.hipatterns (Highlights inline text colors like #FFF or #504945)
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- Mini.cmdline (Beautiful floating command widget)
  vim.schedule(function()
    require('mini.cmdline').setup()
  end)

  -- Mini.clue (Native alternative to Which-Key)
  local miniclue = require('mini.clue')
  miniclue.setup({
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' },
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'i', keys = '<C-x>' },
      { mode = { 'n', 'x' }, keys = 'g' },
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },
      { mode = { 'n', 'x' }, keys = 'z' },
    },
    clues = {
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

      { mode = 'n', keys = '<leader>f', desc = '+Find/Telescope' },
      { mode = 'n', keys = '<leader>q', desc = '+Quit' },
      { mode = 'n', keys = '<leader>w', desc = '+Write/Save' },
      { mode = 'n', keys = '<leader>t', desc = '+Trim Space' },
    },
    window = { config = { border = 'single' } }
  })
end

--------------------------------------------------------------------------------
-- 6. OTHER ECOSYSTEM PLUGINS
--------------------------------------------------------------------------------

-- Treesitter
add({
  source = 'nvim-treesitter/nvim-treesitter',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
local has_ts, ts_configs = pcall(require, 'nvim-treesitter.configs')
if has_ts then
  ts_configs.setup({
    ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    highlight = { enable = true },
  })
end

-- Telescope
add({
  source = 'nvim-telescope/telescope.nvim',
  depends = { 'nvim-lua/plenary.nvim' }
})

-- Native LSP Config
add({ source = 'neovim/nvim-lspconfig' })

-- Lazygit
add({ source = 'kdheepak/lazygit.nvim' })

--------------------------------------------------------------------------------
-- 7. KEYMAPS (Custom Mappings & Shortcuts)
--------------------------------------------------------------------------------
local keymap = vim.keymap.set

-- Lazygit Shortcut
keymap('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Toggle Lazygit' })

-- Clear search highlights on pressing <Esc>
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Global File Saving with Ctrl + S
keymap({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Save File' })

-- Quick Quit All / Save All Mappings
keymap('n', '<leader>qa', '<cmd>qa<CR>', { desc = 'Quit All' })
keymap('n', '<leader>wa', '<cmd>wa<CR>', { desc = 'Save All Files' })

-- Mini.trailspace Shortcuts
if has_mini then
  keymap('n', '<leader>tw', function() require('mini.trailspace').trim() end, { desc = 'Trim Trailing Whitespace' })
  keymap('n', '<leader>tl', function() require('mini.trailspace').trim_last_lines() end, { desc = 'Trim Trailing Empty Lines' })
end

-- Mini.files Toggle
if has_mini then
  local toggle_mini_files = function()
    if not require('mini.files').close() then
      require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end
  end
  keymap('n', '<leader>e', toggle_mini_files, { desc = 'Toggle File Explorer (Mini)' })
end

-- Telescope Keymaps
local has_tele, builtin = pcall(require, 'telescope.builtin')
if has_tele then
  keymap('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
  keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
  keymap('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
end

-- Quick window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Go to Bottom Window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Go to Top Window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window' })
