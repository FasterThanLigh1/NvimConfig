# Neovim Configuration Summary

This Neovim configuration is a modern, well-structured setup using `lazy.nvim` for plugin management.

## Key Architectural Choices:

1.  **`mini.nvim` Suite:** Heavy reliance on the `mini.nvim` plugin suite for a cohesive UI (statusline, file explorer) and editing experience (surround, pairs).
2.  **`telescope.nvim`:** The central tool for all finding, searching, and LSP interaction, with intuitive keymaps.
3.  **Automated Language Support:** `mason.nvim` is used to automatically install and manage LSP servers for a full-stack development environment, including TypeScript, Java, Python, and more.

## Standout Feature:

A standout feature is the excellent use of `mini.clue` to provide on-screen hints for keymaps. This makes the entire configuration highly discoverable and user-friendly.

## Colorscheme:

The active colorscheme is `catppuccin-mocha`.

## Project Structure:

-   **`init.lua`**: The main entry point, which loads the `lazy.nvim` configuration.
-   **`lua/config/lazy.lua`**: The central hub that bootstraps the plugin manager and loads all plugins from the `lua/plugins/` directory.
-   **`lua/plugins/`**: This directory contains individual configuration files for each plugin, defining the editor's features.
-   **`lua/plugins/mini.lua`**: Configures the `mini.nvim` suite, which provides a large part of the core user experience.
-   **`lua/plugins/lsp.lua`**: Defines the code intelligence setup, including LSP servers and linting tools.
-   **`lua/plugins/telescope.lua`**: Configures the primary navigation and search tool, Telescope.
-   **`lua/config/keymap.lua`**: Contains global keymaps not tied to a specific plugin.
