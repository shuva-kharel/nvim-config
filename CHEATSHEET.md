# Neovim quick reference

`<leader>` is **Space**. Press Space and pause for which-key.

| Area | Keys |
| --- | --- |
| Modes | `i` insert, `Esc` normal, `v` visual, `V` line visual, `<C-v>` block visual |
| Move | `h j k l`, `w b e`, `0 $`, `gg G`, `<C-u>/<C-d>` |
| Edit | `u` undo, `<C-r>` redo, `x` delete char, `ciw` change word, `.` repeat |
| Copy/paste | `yy` copy line, `dd` cut line, `p/P` paste, `"+y` system clipboard |
| Search | `/pattern`, `n/N`, `*` word under cursor, `Esc` clear highlight |
| Files | `<leader>w` save, `:e path` open, `:q` quit |
| Telescope | `<leader>ff` files, `fg` grep, `fb` buffers, `fh` help, `fr` recent, `fs/fS` symbols |
| Neo-tree | `<leader>e` toggle, `?` help |
| LSP | `gd` definition, `gD` declaration, `gr` references, `gi` implementation, `K` hover, `<leader>rn` rename, `ca` action, `ci` signature |
| Diagnostics | `[d` previous, `]d` next, `<leader>cd` details, `cq` workspace list |
| Completion | `<C-n>/<C-p>` choose, `<C-Space>` open, Enter accept, `<C-e>` close, `<C-l>/<C-h>` snippet fields |
| Git | `]h/[h` hunks, `<leader>gp` preview, `gs` stage, `gr` reset, `gb` blame, `gd` diff |
| Format | `<leader>cf` format, `cF` toggle on save for buffer |
| Terminal | `<leader>tf` floating, `tb` bottom, `Esc Esc` terminal normal mode |
| Debug | `F5` run, `F10/F11/F12` step, `<leader>db` breakpoint, `dr` REPL, `du` UI, `dx` stop |
| Buffers | `<leader>bn/bp/bd` next/previous/delete |
| Windows | `<leader>sv/sh/sx` split/close, `<C-h/j/k/l>` move |
| AI (opt in) | `Alt-l` accept, `Alt-]/Alt-[` cycle, `Ctrl-]` dismiss |

See [README.md](README.md) for dependencies, installation, languages, and every mapping.
