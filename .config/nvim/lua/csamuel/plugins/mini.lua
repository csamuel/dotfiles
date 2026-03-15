return {
    "echasnovski/mini.nvim",

    config = function()
        local statusline = require "mini.statusline"
        statusline.setup { use_icons = vim.g.have_nerd_font }

        local function get_lsp_clients()
            local clients = vim.lsp.get_clients()

            if #clients == 0 then
                return ""
            end

            local names = {}
            for _, client in ipairs(clients) do
                table.insert(names, client.name)
            end

            local lsp_string = table.concat(names, "|")
            return " " .. lsp_string
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local git = statusline.section_git()
            local diagnostics = statusline.section_diagnostics()
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = statusline.section_location()
            local lsp = get_lsp_clients()

            return statusline.combine_groups {
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
                "%<",
                { hl = "MiniStatuslineFilename", strings = { fileinfo } },
                "%=",
                { hl = "MiniStatuslineFilename", strings = { lsp } },
                { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
                { hl = mode_hl, strings = { location } },
            }
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_diagnostics = function()
            local buffer_diagnostics = {
                errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
                warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
                info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
                hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }),
            }

            local diagnostics = {}
            if buffer_diagnostics.errors > 0 then
                table.insert(diagnostics, string.format(" :%d", buffer_diagnostics.errors))
            end
            if buffer_diagnostics.warnings > 0 then
                table.insert(diagnostics, string.format(" :%d", buffer_diagnostics.warnings))
            end
            if buffer_diagnostics.info > 0 then
                table.insert(diagnostics, string.format(" :%d", buffer_diagnostics.info))
            end
            if buffer_diagnostics.hints > 0 then
                table.insert(diagnostics, string.format(" :%d", buffer_diagnostics.hints))
            end
            return table.concat(diagnostics, " ")
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_fileinfo = function()
            local fname = vim.fn.expand "%:t"
            if fname == "" then
                fname = "[No Name]"
            end
            local readonly = vim.bo.readonly and "🔒" or ""
            local modified = vim.bo.modified and "[+]" or ""
            return string.format(" %s%s%s ", fname, readonly, modified)
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_git = function()
            local head = vim.b.gitsigns_head
            if not head or head == "" then
                return ""
            end
            return string.format(" %s", head)
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end
    end,
}
