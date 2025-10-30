-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            -- ADDED/CONFIRMED PARSERS FOR FULLSTACK DEVELOPMENT:
            ensure_installed = {
                -- Primary Languages
                "typescript",
                "tsx",          -- For React/JSX in TypeScript
                "javascript",   -- For general JS/Node files
                "java",
                "python",

                -- Web & Configuration Languages
                "html",
                "css",
                "json",
                "yaml",
                "markdown",
                "markdown_inline",
                "lua",          -- For Neovim config

                -- You can keep "c", "vim", "vimdoc", "query" if you work with C or use them for query files.
                -- Removed "c" since it was in your previous list but not a primary language for fullstack.
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            -- Only ignore "javascript" if you find it conflicts with "typescript"
            -- or if you truly never want to install it. It's often helpful to keep.
            ignore_install = {
                -- You can add back "javascript" here if you don't want it installed
                -- e.g., "javascript",
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            
            -- Ensure indentation is also enabled, as is common practice
            indent = { enable = true }, 
        },
    },
}
