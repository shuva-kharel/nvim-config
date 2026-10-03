local servers = {
    "clangd",
    "rust_analyzer",
    "lua_ls",
    "basedpyright",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "bashls",
    "taplo",
    "dockerls",
    "docker_compose_language_service",
    "marksman",
}

return {
    { "neovim/nvim-lspconfig", lazy = false }, -- Provides server definitions to vim.lsp.config.
    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })
            vim.lsp.config(
                "clangd",
                { cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" } }
            )
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } },
                },
            })
            vim.lsp.config("basedpyright", {
                -- Also attach to standalone scripts with no project marker.
                root_dir = function(bufnr, on_dir)
                    local name = vim.api.nvim_buf_get_name(bufnr)
                    if name == "" then
                        return
                    end
                    on_dir(vim.fs.root(name, {
                        "pyrightconfig.json",
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "manage.py",
                        "uv.lock",
                        ".git",
                    }) or vim.fs.dirname(name))
                end,
                settings = { basedpyright = { analysis = { typeCheckingMode = "standard" } } },
            })
            require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = servers })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("PersonalLspMaps", { clear = true }),
                callback = function(event)
                    local buf = event.buf
                    local map = function(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
                    end
                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("gr", vim.lsp.buf.references, "References")
                    map("gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("K", vim.lsp.buf.hover, "Hover documentation")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>cs", vim.lsp.buf.document_symbol, "Document symbols")
                    map("<leader>cS", vim.lsp.buf.workspace_symbol, "Workspace symbols")
                    map("<leader>ci", vim.lsp.buf.signature_help, "Signature help")
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.name == "clangd" then
                        map("<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", "Switch source/header")
                    end
                end,
            })
        end,
    },
}
