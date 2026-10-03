# Neovim development environment

A keyboard driven, modular Neovim configuration for C/C++, Rust, Python, web development, and common configuration files. It keeps the original four space default, relative numbers, system clipboard, persistent undo, rounded borders, Neo-tree, and Catppuccin Mocha. Plugins are managed directly with lazy.nvim.

## Screenshots

Add screenshots of the editor, Telescope, Neo-tree, and DAP UI to `docs/screenshots/` after opening a real project. A Nerd Font and a true color terminal give the intended appearance.

## Requirements

**Core:** Neovim 0.12.5, Git, a C compiler for Treesitter parsers, a Nerd Font, and [ripgrep](https://github.com/BurntSushi/ripgrep) for live grep. [fd](https://github.com/sharkdp/fd) speeds up file finding; Telescope can also use ripgrep. Windows clipboard support uses Neovim's bundled `win32yank`.

**Windows C/C++:** Install LLVM with `winget install --id LLVM.LLVM --exact` to provide `clang`, `clang++`, `clangd`, `clang-format`, and `clang-tidy` as one toolchain. This setup uses the CMake and Ninja bundled with Visual Studio 2026; standalone CMake and Ninja also work. The config finds LLVM, Visual Studio's CMake/Ninja, winget's ripgrep/fd, and an installed 7-Zip inside Neovim without changing the permanent PATH. When LLVM is absent, it can import an installed Visual Studio developer environment for its C compiler. A normal C/C++ compiler and CMake remain required for full C/C++ use.

**Other system tools:** Node.js/npm support the web LSPs and js-debug. Python 3.14 with `pynvim` supports the Python provider; project virtual environments remain independent. Git is needed for lazy.nvim and gitsigns. On the audited Windows machine, ripgrep 15.2, fd 10.5, Visual Studio 2026, CMake, Ninja, Python 3.14, Node 24, and 7-Zip were already present. LLVM 23.1.2 was installed for this setup. Docker, databases, and project runtimes remain project dependencies.

**Debugging:** Mason supplies `codelldb`, `debugpy`, and `js-debug-adapter`. For C/C++/Rust, build a binary with debug symbols first (`clang -g` or a Debug CMake build). Python debugging uses the active `VIRTUAL_ENV` when present. JS/TS debugging needs Node.js; TypeScript needs emitted JavaScript with source maps or a compatible runtime such as `tsx`. The DAP paths follow current Mason package layouts; check `:Mason` after package updates.

## Installation

On Windows PowerShell, back up an existing config, then clone into `$env:LOCALAPPDATA\nvim`. Install the system tools you actually use; the C/C++ toolchain command is:

```powershell
winget install --id LLVM.LLVM --exact
$config = Join-Path $env:LOCALAPPDATA 'nvim'
if (Test-Path $config) { Move-Item $config "$config.backup.$(Get-Date -Format yyyyMMdd-HHmmss)" }
git clone https://github.com/shuva-kharel/nvim-config $config
nvim
```

If the config directory already exists, update that checkout instead of cloning over it. Start `nvim`, run `:Lazy sync`, then inspect `:Mason`, `:LspInfo`, and `:checkhealth`. The installed Mason packages listed below can be added with `:MasonInstall <package>`. The config detects existing Windows system tools when winget has not added them to PATH.

On Linux, back up an existing config before cloning:

```sh
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
git clone https://github.com/shuva-kharel/nvim-config ~/.config/nvim
nvim
```

Use `~/.config/nvim` on macOS. On other machines, install the system dependencies through their native package managers. `:TSInstall` is available if a parser failed.

## Structure

`init.lua` sets leaders and loads `lua/config/`. `options.lua` preserves editor defaults, `keymaps.lua` has general mappings and diagnostics, `autocmds.lua` handles indentation and yank feedback, and `lazy.lua` loads `lua/plugins/`. Each plugin module owns one feature. `lazy-lock.json` pins installed plugin revisions.

## Plugins

| Plugin | Purpose |
| --- | --- |
| lazy.nvim | Plugin manager |
| Catppuccin | Mocha color scheme |
| nvim-web-devicons | Nerd Font icons |
| Neo-tree, plenary, nui | File explorer and its dependencies |
| Telescope | Files, grep, buffers, help, symbols |
| nvim-treesitter | Syntax parsers, highlights, stable indentation |
| nvim-lspconfig, Mason, mason-lspconfig | Native LSP definitions and tooling |
| blink.cmp | LSP, path, snippets, buffer, and command line completion |
| conform.nvim | Formatting |
| nvim-lint | Extra lint rules |
| gitsigns.nvim | Hunks, signs, blame, diff |
| toggleterm.nvim | Floating and bottom terminals |
| nvim-dap, nvim-dap-ui, nvim-nio | Debugging and UI |
| which-key.nvim | Leader command discovery |
| lualine.nvim | Compact status line |
| todo-comments.nvim | TODO/FIXME highlighting |
| copilot.lua | Enabled AI suggestions; GitHub sign-in required |

## Language support

Mason v2 and mason-lspconfig automatically install the configured LSP servers **except clangd**, which comes from system LLVM. mason-lspconfig v2 enables its servers through Neovim's native `vim.lsp` API. Mason also manages the installed formatter, linter, and debugger packages listed here. ESLint itself and its rules belong in each JS/TS project.

| Language | LSP | Formatter | Linter | Debugger | Treesitter |
| --- | --- | --- | --- | --- | --- |
| C/C++ | system clangd | system clang-format | clangd with clang-tidy | codelldb | c, cpp |
| Rust | rust-analyzer | rustfmt | rust-analyzer/clippy via Cargo | codelldb | rust |
| Python, Django, FastAPI | basedpyright | Ruff format | Ruff | debugpy | python |
| JS/TS, Node, React, Next | ts_ls | prettierd or prettier | eslint_d | js-debug-adapter | javascript, typescript, tsx |
| HTML/CSS/SCSS | html, cssls | prettierd or prettier | LSP | — | html, css, scss |
| JSON/JSONC | jsonls | prettierd or prettier | LSP | — | json, jsonc |
| YAML | yamlls | prettierd or prettier | LSP | — | yaml |
| Bash/sh | bashls | shfmt | ShellCheck | — | bash |
| Lua | lua_ls | stylua | LSP | — | lua |
| TOML | taplo | LSP fallback | LSP | — | toml |
| Markdown | marksman | prettierd or prettier | LSP | — | markdown, markdown_inline |
| SQL | — | sql-formatter | — | — | sql |
| Dockerfile/Compose | dockerls, docker_compose_language_service | LSP fallback | LSP | — | dockerfile, yaml |
| Git config | — | — | — | — | git_config |

Currently installed Mason packages include `basedpyright`, `typescript-language-server` (`ts_ls`), `html-lsp`, `css-lsp`, `json-lsp`, `yaml-language-server`, `lua-language-server`, `rust-analyzer`, and the other LSPs shown in the table. Mason also supplies `ruff`, `prettierd`, `stylua`, `shfmt`, `sql-formatter`, `eslint_d`, `shellcheck`, `codelldb`, `debugpy`, and `js-debug-adapter`. `clangd` and `clang-format` are intentionally system managed so the compiler, LSP, and formatter share one LLVM installation. `rustfmt` comes from `rustup component add rustfmt` when Rust is installed. Conform tries `prettierd` first and project/system `prettier` only if unavailable; `stop_after_first` prevents both from formatting one save. Conform invokes LSP formatting only when no external formatter is available. Ruff adds Python style diagnostics alongside basedpyright type checking. `eslint_d` needs ESLint installed and configured in the project.

For CMake projects on Windows, generate `compile_commands.json` with `cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++`. If clangd does not find it in `build`, copy it to the project root (`Copy-Item build\compile_commands.json .`) or set `CompilationDatabase: build` in a project `.clangd` file. The `--clang-tidy` flag enables clangd's integrated clang-tidy checks. `<leader>ch` switches header/source after clangd attaches.

Rust is ready in the config, but this machine has no Rust toolchain. When you start Rust work, install [rustup](https://rustup.rs/), run `rustup component add rustfmt`, and use Cargo for builds and Clippy. Mason already has `rust-analyzer` and `codelldb`; Rust debugging starts after you build a binary with debug information.

To add a language: add its server name in `lua/plugins/lsp.lua`, its parser in `treesitter.lua`, then choose a formatter in `formatting.lua` and an optional linter in `linting.lua`. Add a DAP adapter only if you actually use debugging for it.

## AI completion

GitHub Copilot is enabled through `copilot.lua` and needs a GitHub account and internet access. The plugin is installed, but sign-in is a separate personal step. Copilot sends code context to GitHub for suggestions. See [GitHub's plan details](https://docs.github.com/en/copilot/managing-copilot/managing-copilot-as-an-individual-subscriber/getting-started-with-copilot-on-your-personal-account/about-individual-copilot-plans-and-benefits) for current limits.

To sign in, run `:Copilot auth` in Neovim and finish the GitHub browser/device flow, then use `:Copilot status`. No credentials are stored in this repository. To disable Copilot later, change `vim.g.enable_copilot = true` in `init.lua` to `false` and restart. LSP and blink.cmp operate independently of Copilot. Its suggestion keys are listed below; terminal support for Alt combinations varies.

## Troubleshooting and health checks

- `:LspInfo` is an alias for `:checkhealth vim.lsp` on Neovim 0.12. Open a source file first to see active clients. `:Mason` shows Mason packages; system LLVM tools do not appear as installed Mason packages.
- If C/C++ LSP features are missing, check `:echo exepath('clangd')`, `:LspInfo`, and the project's `compile_commands.json`. For parser build failures, check `:echo exepath('clang')` and reinstall that parser with `:TSInstall c cpp`.
- For Telescope, check `:echo exepath('rg')` and `:echo exepath('fd')`. `<leader>fg` needs ripgrep; `<leader>ff` uses fd when available.
- `:ConformInfo`, `:checkhealth`, `:checkhealth mason`, and `:DapShowLog` help diagnose formatting, package installation, and debugging failures. Restart Neovim after installing Windows tools so new processes see them.
- Mason health lists optional runtimes such as Go, Ruby, PHP, Julia, and cargo. Install them only for projects that need them. `unzip`, `gzip`, and `wget` are not needed for the packages verified here. lazy.nvim's LuaRocks support is disabled because no installed plugin requires it. Unknown compound LSP filetypes and the built-in `gc`/`gcc` which-key overlap are informational. Neovim's `vim.pack` warnings concern separate package state and do not affect lazy.nvim.

## Keybindings

`<leader>` = **Space**. `<C-x>` = Ctrl+x, `<M-x>` = Alt+x. Entries marked “default” are built into Neovim.

### General

| Shortcut | Action |
| --- | --- |
| `<leader>w` | Save file |
| `<Esc>` | Clear search highlight in normal mode |
| `:q`, `:wq`, `:qa` | Quit, save and quit, quit all (default) |
| `u`, `<C-r>` | Undo, redo (default) |
| `i`, `a`, `v`, `V`, `<C-v>` | Insert, append, visual, visual line, visual block (default) |

### Navigation

| Shortcut | Action |
| --- | --- |
| `h j k l`, `w b e`, `0 $`, `gg G` | Move by character, word, line, file (default) |
| `<C-u>`, `<C-d>` | Half page up/down (default) |
| `/text`, `n`, `N` | Search, next, previous (default) |
| `<C-o>`, `<C-i>` | Jump back/forward (default) |

### File Explorer

| Shortcut | Action |
| --- | --- |
| `<leader>e` | Toggle Neo-tree |
| `?` | Neo-tree help while focused |

### Fuzzy Finding

| Shortcut | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (ripgrep) |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fs`, `<leader>fS` | Document, workspace symbols |

### LSP

These buffer mappings appear when an LSP attaches.

| Shortcut | Action |
| --- | --- |
| `gd`, `gD`, `gr`, `gi` | Definition, declaration, references, implementation |
| `K` | Hover docs |
| `<leader>rn`, `<leader>ca` | Rename, code action |
| `<leader>cs`, `<leader>cS` | Document, workspace symbols |
| `<leader>ci` | Signature help in normal mode |
| `<leader>ch` | clangd header/source switch |

### Completion

| Shortcut | Action |
| --- | --- |
| `<C-n>`, `<C-p>` | Next/previous completion in insert mode |
| `<C-Space>` | Trigger or cycle documentation |
| `<CR>` | Confirm selected completion |
| `<C-e>` | Close completion menu |
| `<C-b>`, `<C-f>` | Scroll completion docs |
| `<C-k>` | Signature popup in insert mode |
| `<C-l>`, `<C-h>` | Next/previous snippet field in insert mode |

### Diagnostics

| Shortcut | Action |
| --- | --- |
| `[d`, `]d` | Previous/next diagnostic |
| `<leader>cd` | Line diagnostic details |
| `<leader>cq` | Workspace diagnostics quickfix |

### Formatting

| Shortcut | Action |
| --- | --- |
| `<leader>cf` | Format buffer or visual selection |
| `<leader>cF` | Toggle format on save for current buffer |
| `:ConformInfo` | Show active formatter and log |

### Git

Git mappings appear in tracked buffers.

| Shortcut | Action |
| --- | --- |
| `]h`, `[h` | Next/previous hunk |
| `<leader>gp`, `<leader>gs`, `<leader>gr` | Preview, stage, reset hunk |
| `<leader>gS` | Stage whole buffer |
| `<leader>gb`, `<leader>gd` | Blame line, diff against index |

### Terminal

| Shortcut | Action |
| --- | --- |
| `<leader>tf` | New floating terminal |
| `<leader>tb` | Toggle bottom terminal |
| `<Esc><Esc>` | Leave toggleterm terminal mode |
| `<C-h/j/k/l>` | Move to another window from terminal |
| `i` | Return to terminal input from normal mode (default) |

### Debugging

| Shortcut | Action |
| --- | --- |
| `<F5>` | Start or continue |
| `<F10>`, `<F11>`, `<F12>` | Step over, into, out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dr`, `<leader>du`, `<leader>dx` | REPL, UI, terminate |

### Buffers

| Shortcut | Action |
| --- | --- |
| `<leader>bn`, `<leader>bp`, `<leader>bd` | Next, previous, delete buffer |
| `:b filename`, `:ls` | Switch buffer, list buffers (default) |

### Windows/Splits

| Shortcut | Action |
| --- | --- |
| `<leader>sv`, `<leader>sh`, `<leader>sx` | Vertical split, horizontal split, close split |
| `<C-h/j/k/l>` | Move between windows |
| `<C-w>=`, `<C-w>q` | Equalize sizes, close window (default) |

### Treesitter/Text Objects

Treesitter supplies syntax highlighting and indentation where stable. Standard Vim text objects remain available: `ciw` changes a word, `di(` deletes inside parentheses, and `va"` selects quoted text. No custom Treesitter text object keys are installed.

### AI Completion

Only when Copilot is enabled:

| Shortcut | Action |
| --- | --- |
| `<M-l>` | Accept AI suggestion |
| `<M-]>`, `<M-[>` | Next/previous AI suggestion |
| `<C-]>` | Dismiss AI suggestion |
