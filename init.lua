--------------------------------------------------------------------------------
-- 1. SET LEADER KEYS (Must be defined before plugins/mappings)
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
    -- Mini.icons
    require('mini.icons').setup()

    -- Mini.files
    require('mini.files').setup()

    -- Mini.statusline
    require('mini.statusline').setup()

    -- Mini.tabline
    require('mini.tabline').setup()

    -- Mini.ai
    require('mini.ai').setup()

    -- Mini.pairs
    require('mini.pairs').setup()

    -- Mini.bracketed
    require('mini.bracketed').setup()

    -- Mini.visits
    require('mini.visits').setup()

    -- Mini.indentscope
    require('mini.indentscope').setup({ symbol = "│" })

    -- Mini.notify
    require('mini.notify').setup()
    vim.notify = require('mini.notify').make_notify()

    -- Mini.starter
    require('mini.starter').setup()

    -- Mini.trailspace
    require('mini.trailspace').setup()

    -- Mini.animate
    require('mini.animate').setup()

    -- Mini.cursorword
    require('mini.cursorword').setup()

    -- Mini.completion
    require('mini.completion').setup({
        delay = { completion = 100, info = 200 },
        window = {
            info = { border = 'single' },
            signature = { border = 'single' },
        }
    })

    -- Mini.hipatterns
    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
        highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })

    -- Mini.cmdline
    vim.schedule(function()
        require('mini.cmdline').setup()
    end)

    -- Mini.clue (Native Keymap Guide Setup)
    local miniclue = require('mini.clue')
    miniclue.setup({
        triggers = {
            { mode = { 'n', 'x' }, keys = '<Leader>' },
            { mode = 'n',          keys = '[' },
            { mode = 'n',          keys = ']' },
            { mode = 'i',          keys = '<C-x>' },
            { mode = { 'n', 'x' }, keys = 'g' },
            { mode = { 'n', 'x' }, keys = "'" },
            { mode = { 'n', 'x' }, keys = '`' },
            { mode = { 'n', 'x' }, keys = '"' },
            { mode = { 'i', 'c' }, keys = '<C-r>' },
            { mode = 'n',          keys = '<C-w>' },
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
            { mode = 'n', keys = '<leader>g', desc = '+Git' },
            { mode = 'n', keys = '<leader>l', desc = '+LSP/Code' }, -- Registered LSP menu group
            { mode = 'n', keys = '<leader>m', desc = '+Minimap' },
        },
        window = { config = { border = 'single' } }
    })

    local minimap = require('mini.map')
    minimap.setup({
        -- Integrate line diagnostics (errors/warnings) and git status into the side scrollbar
        integrations = {
            minimap.gen_integration.builtin_search(),
            minimap.gen_integration.diagnostic({
                error = 'DiagnosticFloatingError',
                warn  = 'DiagnosticFloatingWarn',
                info  = 'DiagnosticFloatingInfo',
                hint  = 'DiagnosticFloatingHint',
            }),
        },
        symbols = {
            encode = minimap.gen_encode_symbols.dot('2x2'), -- Clean, dense dot mapping
        },
        window = {
            side = 'right',
            width = 12, -- Slick, narrow profile
        }
    })
end

--------------------------------------------------------------------------------
-- 6. MASON & LSP AUTOMATED SETUP (Updated to mason-org)
--------------------------------------------------------------------------------
add({
    source = 'neovim/nvim-lspconfig',
    depends = {
        'mason-org/mason.nvim',           -- Updated organization path
        'mason-org/mason-lspconfig.nvim', -- Updated organization path
    }
})

local has_mason, mason = pcall(require, "mason")
local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if has_mason and has_lspconfig then
    -- Initialize Mason package manager
    mason.setup({
        ui = { border = "single" }
    })

    -- Fetch standard native capabilities safely
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Explicitly setup the Lua Language Server natively
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        }
    })
end

--------------------------------------------------------------------------------
-- 7. OTHER EXTRA PLUGINS
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

-- Lazygit Bridge
add({ source = 'kdheepak/lazygit.nvim' })

--------------------------------------------------------------------------------
-- 8. KEYMAPS (Custom Mappings & Shortcuts)
--------------------------------------------------------------------------------
local keymap = vim.keymap.set

-- Clear search highlights on pressing <Esc>
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Global File Saving with Ctrl + S
keymap({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR><Esc>', { desc = 'Save File' })

-- Quick Quit All / Save All Mappings
keymap('n', '<leader>qa', '<cmd>qa<CR>', { desc = 'Quit All' })
keymap('n', '<leader>wa', '<cmd>wa<CR>', { desc = 'Save All Files' })

-- Lazygit Shortcut
keymap('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Toggle Lazygit' })

-- Mini.trailspace Shortcuts
if has_mini then
    keymap('n', '<leader>tw', function() require('mini.trailspace').trim() end, { desc = 'Trim Trailing Whitespace' })
    keymap('n', '<leader>tl', function() require('mini.trailspace').trim_last_lines() end,
        { desc = 'Trim Trailing Empty Lines' })
end

-- Mini.completion Keymaps (Super-Tab behavior for popups)
if has_mini then
    vim.g.minipairs_disable = false
    keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
end

-- Toggle IntelliJ-Style Minimap
if has_mini then
  keymap('n', '<leader>mc', function() require('mini.map').close() end, { desc = 'Close Minimap' })
  keymap('n', '<leader>mo', function() require('mini.map').open() end, { desc = 'Open Minimap' })
  keymap('n', '<leader>mm', function() require('mini.map').toggle() end, { desc = 'Toggle Minimap' })
end

-- Native LSP Navigation Shortcuts (Only active when an LSP attaches to a file)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Floating contextual action items
        keymap('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'LSP Hover Docs' })
        keymap('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to Definition' })
        keymap('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Go to Declaration' })
        keymap('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'Go to Implementation' })
        keymap('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'Show References' })

        -- Leader Grouped Actions (Will show cleanly in mini.clue!)
        keymap('n', '<leader>lR', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename Symbol' })
        keymap({ 'n', 'v' }, '<leader>lc', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code Actions' })
        keymap('n', '<leader>ld', vim.diagnostic.open_float, { buffer = ev.buf, desc = 'Line Diagnostics' })

        keymap('n', 'gl', vim.diagnostic.open_float, { buffer = ev.buf, desc = 'Line Diagnostics' })
        keymap('n', 'g=', function() vim.lsp.buf.format({ async = true }) end, { buffer = ev.buf, desc = 'Format File' })
    end,
})

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
