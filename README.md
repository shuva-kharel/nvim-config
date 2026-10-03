# Neovim development environment

A keyboard driven, modular Neovim configuration for C/C++, Rust, Python, web development, and common configuration files. It keeps the original four space default, relative numbers, system clipboard, persistent undo, rounded borders, Neo-tree, and Catppuccin Mocha. Plugins are managed directly with lazy.nvim.

## Screenshots

Add screenshots of the editor, Telescope, Neo-tree, and DAP UI to `docs/screenshots/` after opening a real project. A Nerd Font and a true color terminal give the intended appearance.

## Requirements

**Core:** Neovim 0.11 or newer (tested with 0.12.5), Git, a C compiler and `tree-sitter` parser build prerequisites, a Nerd Font, and [ripgrep](https://github.com/BurntSushi/ripgrep) for live grep. [fd](https://github.com/sharkdp/fd) is optional; Telescope falls back to its normal file search when it is absent. A working clipboard provider is needed for `unnamedplus`.

**Language tooling:** Mason installs the listed LSP servers. Node.js and npm are needed for many JavaScript based tools. Install a C/C++ compiler, CMake, GDB or LLDB, and `clangd`/`clang-format` if Mason cannot provide them on your platform. Rust needs the Rust toolchain and `rustfmt`; Python needs a real interpreter and `pip`/virtual environments. Docker, SQL databases, and project runtimes remain external.

**Debugging:** Install `codelldb`, `debugpy`, and `js-debug-adapter` using `:MasonInstall codelldb debugpy js-debug-adapter`. For C/C++/Rust, build a binary with debug symbols first. For Python, select a working interpreter or activate a virtual environment. For JS/TS, Node.js is required; TypeScript needs emitted JavaScript and source maps or a compatible runtime such as `tsx`. Adapter paths are based on Mason package layouts; check `:Mason` if a package changes layout.

## Installation

On Linux, back up an existing config before cloning:

```sh
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
git clone https://github.com/shuva-kharel/nvim-config ~/.config/nvim
nvim
```

Use Homebrew paths (`~/.config/nvim`) on macOS. On Windows, use `%LOCALAPPDATA%\nvim` and back up that directory first. Run `:Lazy sync`, then `:Mason` to inspect installations. `:TSInstall` is available if a parser failed. Run `:checkhealth` after installing system dependencies.

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
| copilot.lua | Optional, disabled AI suggestions |

## Language support

Mason automatically installs the LSP servers below. Formatters, linters, and debugger adapters are installed separately with `:MasonInstall` or your system package manager. Project tools such as ESLint should usually be installed in the project.

| Language | LSP | Formatter | Linter | Debugger | Treesitter |
| --- | --- | --- | --- | --- | --- |
| C/C++ | clangd | clang-format | clangd/clang-tidy | codelldb | c, cpp |
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

Install formatter/linter packages as needed: `:MasonInstall clang-format stylua ruff prettierd shfmt sql-formatter eslint_d shellcheck`. `rustfmt` comes from `rustup component add rustfmt`. Project local Prettier and ESLint configurations control their rules. Conform uses external formatters first and LSP formatting only as a fallback, so two formatters do not run on one save. Ruff's lint rules complement basedpyright type checks. `eslint_d` requires an ESLint project setup.

For CMake projects, generate `compile_commands.json` with `cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`, then link or copy it to the project root if clangd cannot find it. `clangd --clang-tidy` keeps compiler and clang-tidy warnings visible. `<leader>ch` switches header/source after clangd attaches.

To add a language: add its server name in `lua/plugins/lsp.lua`, its parser in `treesitter.lua`, then choose a formatter in `formatting.lua` and an optional linter in `linting.lua`. Add a DAP adapter only if you actually use debugging for it.

## AI completion

The optional provider is GitHub Copilot Free via `copilot.lua`. It needs a GitHub account and internet access. Free plans have monthly completion limits that GitHub may change; check [current plan details](https://docs.github.com/en/copilot/managing-copilot/managing-copilot-as-an-individual-subscriber/getting-started-with-copilot-on-your-personal-account/about-individual-copilot-plans-and-benefits). Copilot sends code context to GitHub for suggestions. It is **off by default**, so no AI plugin is installed or code transmitted by this config until you opt in.

To enable, add `vim.g.enable_copilot = true` near the top of `init.lua`, before `require("config.lazy")`; restart, run `:Lazy sync`, then `:Copilot auth` and `:Copilot status`. Remove that line to disable it. LSP and blink.cmp operate independently of Copilot. Its suggestion keys are listed below; terminal support for Alt combinations varies.

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
