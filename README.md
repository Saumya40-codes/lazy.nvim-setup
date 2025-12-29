# Neovim config (lazy.nvim)

Quick start
- Install Neovim (0.10+ recommended).
- Open Neovim; this config uses lazy.nvim to manage plugins and will prompt to install plugins if missing.

Language specifics (optional)
- Install a Java JDK (11+): ensure `java -version` works.
- Install the Java language server with Mason inside Neovim: `:Mason` then `:MasonInstall jdtls` (or install jdtls manually and put a launcher on PATH).
- Applies same for go and install gopls and also gofumpt via `:MasonInstall` have it on PATH as well.

Manage plugins
- Plugin specs live under `lua/plugins/` and configuration under `lua/config/`.
- After editing plugins, run `:Lazy sync` (or `:Lazy` UI) to apply changes.

Edit configuration
- main entry: `init.lua` (loads `lua/config/lazy.lua`).
- Common config files: `lua/config/*.lua`.

Formatting and tooling
- Stylua config: `stylua.toml` (this repo uses 2-space indentation).
- Neodev is configured via `.neoconf.json` for better Lua LSP support.

Verify
- Check installed tools: `:Mason` UI.
- LSP status: `:LspInfo`.
- Plugin manager: `:Lazy`.

Troubleshooting
- If LSP/completion doesn't work for Java: ensure JDK + jdtls are installed and you opened a project with root markers (pom.xml, build.gradle, .git).
- If a plugin change doesn't load: run `:Lazy sync` and restart Neovim.