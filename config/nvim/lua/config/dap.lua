local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup({})

-- Open/close dap-ui automatically
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- lldb-dap adapter (Fedora ships at /usr/bin/lldb-dap)
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-dap",
    name = "lldb",
}

local c_config = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
            local input = vim.fn.input("Args (space-separated): ")
            if input == "" then return {} end
            return vim.split(input, " ", { trimempty = true })
        end,
    },
    {
        name = "Attach to process",
        type = "lldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        args = {},
    },
}

dap.configurations.c = c_config
dap.configurations.cpp = c_config

-- Diagnostic signs
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })
