# My Neovim Configuration

Welcome to my custom Neovim configuration! 🎨 This setup is designed for performance, simplicity, and extensibility. With [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager, you can effortlessly add or remove plugins as needed.

---

## ✨ Features

- **Modern Neovim Setup**: Built on Neovim 0.8+ for the latest features and improvements.
- **Plugin Management**: Powered by Lazy.nvim for fast and reliable plugin handling.
- **Optimized Performance**: Minimalistic configuration for a blazing-fast experience.
- **Custom Keybindings**: Intuitive mappings for efficient editing.
- **Beautiful UI**: Enhanced visuals with themes and icons.

---

## 🛠 Installation

### Prerequisites

1. Ensure you have Neovim 0.8 or higher installed.
2. Install a Nerd Font (e.g., [FiraCode Nerd Font](https://www.nerdfonts.com)) for proper icon support.
3. Ensure the following dependencies are installed:
   - **Ripgrep** (for `live_grep` in Telescope):
     - **Linux**: `sudo apt install ripgrep` (Debian/Ubuntu) or `sudo pacman -S ripgrep` (Arch)
     - **macOS**: `brew install ripgrep`
     - **Windows**: Download it from [Ripgrep Releases](https://github.com/BurntSushi/ripgrep/releases) and add it to your `PATH`.

### Setup

1. Backup any existing Neovim configuration:

   ```bash
   mv ~/.config/nvim ~/.config/nvim-backup  # Linux/macOS
   ren %APPDATA%\nvim %APPDATA%\nvim-backup  # Windows
   ```

2. Clone this repository into your Neovim configuration directory:
   - **Linux/macOS**:
     ```bash
     git clone https://github.com/shuva-kharel/nvim-config.git ~/.config/nvim
     ```
   - **Windows**:
     ```bash
     git clone https://github.com/shuva-kharel/nvim-config.git %APPDATA%\nvim
     ```

3. Open Neovim and install plugins:
   - Simply open Neovim:
     ```bash
     nvim
     ```
     Lazy.nvim will automatically install plugins on startup.

4. Restart Neovim and enjoy your new setup! 🚀

---

## 📦 Plugins

This configuration leverages the power of these amazing plugins:

| Plugin                       | Description                                     |
|------------------------------|-------------------------------------------------|
| [Lazy.nvim](https://github.com/folke/lazy.nvim) | Fast plugin manager.                        |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Better syntax highlighting.                |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Beautiful status line.                     |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder and file explorer.            |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion framework.                   |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration.                           |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer.                              |

---

## 🖥 Screenshots

Here is a glimpse of my setup in action:

![Dashboard Example](https://via.placeholder.com/800x400?text=Neovim+Dashboard)
![Code Editing Example](https://via.placeholder.com/800x400?text=Code+Editing+with+Treesitter)

---

## 📖 Keybindings

Here are some custom keybindings that make editing a breeze:

| Keybinding      | Action                      |
|------------------|-----------------------------|
| `<leader>ff`    | Find files using Telescope. |
| `<leader>fg`    | Live grep with Telescope.   |
| `<leader>e`     | Open file explorer.         |
| `<leader>q`     | Quit Neovim.                |

Make sure these keybindings match the mappings in your `keymaps.lua`.

---

## 🧩 Customization

Feel free to modify the configuration to suit your preferences. The setup is modular and easy to extend. Simply edit the files in the `lua/` directory.

To customize specific plugins, navigate to `lua/plugins/` and modify their corresponding configuration files.

---

## 🤝 Contributions

If you have suggestions or improvements, feel free to open an issue or submit a pull request. Contributions are always welcome! 🌟

---

## 💬 Acknowledgements

Special thanks to:
- [folke](https://github.com/folke) for Lazy.nvim and other amazing plugins.
- The [Neovim](https://neovim.io/) community for their dedication to making coding joyful.
- All plugin authors for their contributions to the ecosystem.

---

Happy coding! 🖤
