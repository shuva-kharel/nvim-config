return {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    keys = {
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            desc = "Start or continue debugging",
        },
        {
            "<F10>",
            function()
                require("dap").step_over()
            end,
            desc = "Step over",
        },
        {
            "<F11>",
            function()
                require("dap").step_into()
            end,
            desc = "Step into",
        },
        {
            "<F12>",
            function()
                require("dap").step_out()
            end,
            desc = "Step out",
        },
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle breakpoint",
        },
        {
            "<leader>dr",
            function()
                require("dap").repl.open()
            end,
            desc = "Open debug REPL",
        },
        {
            "<leader>du",
            function()
                require("dapui").toggle()
            end,
            desc = "Toggle debugger UI",
        },
        {
            "<leader>dx",
            function()
                require("dap").terminate()
            end,
            desc = "Terminate debugging",
        },
    },
    config = function()
        local dap = require("dap")
        local ui = require("dapui")
        ui.setup()
        dap.listeners.after.event_initialized["dapui"] = function()
            ui.open()
        end
        dap.listeners.before.event_terminated["dapui"] = function()
            ui.close()
        end
        dap.listeners.before.event_exited["dapui"] = function()
            ui.close()
        end

        local mason = vim.fn.stdpath("data") .. "/mason/packages/"
        local win = vim.fn.has("win32") == 1
        local codelldb = mason .. "codelldb/extension/adapter/codelldb" .. (win and ".exe" or "")
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = { command = codelldb, args = { "--port", "${port}" } },
        }
        local compiled = {
            {
                name = "Launch executable (build first)",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        dap.configurations.c = compiled
        dap.configurations.cpp = compiled
        dap.configurations.rust = compiled

        local python = mason .. "debugpy/venv/" .. (win and "Scripts/python.exe" or "bin/python")
        dap.adapters.python = { type = "executable", command = python, args = { "-m", "debugpy.adapter" } }
        dap.configurations.python = {
            {
                name = "Python: current file",
                type = "python",
                request = "launch",
                program = "${file}",
                pythonPath = function()
                    local venv = os.getenv("VIRTUAL_ENV")
                    if venv then
                        return venv .. (win and "/Scripts/python.exe" or "/bin/python")
                    end
                    return win and "python" or "python3"
                end,
            },
        }

        -- Mason's js-debug-adapter package supplies Microsoft's DAP server.
        local js = mason .. "js-debug-adapter/js-debug/src/dapDebugServer.js"
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = { command = "node", args = { js, "${port}" } },
        }
        local node = {
            {
                name = "Node: current file",
                type = "pwa-node",
                request = "launch",
                program = "${file}",
                cwd = "${workspaceFolder}",
                sourceMaps = true,
                protocol = "inspector",
                console = "integratedTerminal",
            },
            {
                name = "Node: attach",
                type = "pwa-node",
                request = "attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
                sourceMaps = true,
            },
        }
        for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
            dap.configurations[ft] = node
        end
    end,
}
