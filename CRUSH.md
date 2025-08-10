CRUSH.md — playbook for this Neovim config repo

Repo type
- Neovim Lua configuration managed by lazy.nvim. No external build; startup is via Neovim.

Run/test/lint commands
- Launch Neovim with this config: nvim -u ~/.config/nvim/init.lua
- Sync/install plugins: open Neovim then :Lazy sync (CLI: nvim --headless '+Lazy! sync' +qa)
- Update Treesitter parsers: nvim --headless '+TSUpdateSync' +qa
- Health check: nvim --headless '+checkhealth' +qa
- Lua lint: use stylua and luacheck if available
  - stylua: stylua .
  - luacheck: luacheck .
- Run a single health/test-like check (headless): nvim --headless '+verbose lua=1' +qa (or run a specific command e.g., nvim --headless '+lua print("ok")' +qa)

Style guidelines (Lua + Neovim)
- Imports: use require("module.path") with double quotes; cache locals for hot paths (local M = {}; local lsp = require("lspconfig")).
- Formatting: 2-space indent, no tabs; keep lines reasonably short; trailing commas allowed in tables; no comments added unless explicitly requested.
- Module pattern: return tables from plugin spec files; use config = function() ... end for plugin setup.
- Naming: lower_snake_case for locals and functions; PascalCase only for external APIs; single-letter only for obvious iterators.
- Types: prefer descriptive tables; avoid global state; expose only what you return; use local for everything.
- Error handling: wrap optional deps using pcall(require, "...") and guard on ok; avoid noisy prints—use vim.notify on user-facing warnings; do not log secrets.
- Neovim API: prefer vim.keymap.set over legacy mappings; use vim.opt/vim.g; avoid setting globals unless necessary; use autocmds via vim.api.nvim_create_autocmd.
- LSP/formatting: leverage server capabilities; on save fixes should be explicit (BufWritePre hooks). Keep diagnostic UI minimal and non-spammy.
- Plugin specs: follow lazy.nvim conventions (spec tables, dependencies, keys, opts/config). Keep side effects in config blocks only.

Cursor/Copilot rules
- No .cursor/rules or .cursorrules or .github/copilot-instructions.md found; nothing to import.

Housekeeping
- Ignore local agent artifacts: add .crush/ to .gitignore.
