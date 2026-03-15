return {
    "saghen/blink.cmp",
    event = "InsertEnter",

    version = "1.*",
    dependencies = {"folke/lazydev.nvim"},

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter"
        },

        appearance = {
            nerd_font_variant = "mono"
        },

        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500
            },

            menu = {
                draw = {
                    columns = {{
                        "kind_icon",
                        "label",
                        "label_description",
                        gap = 1
                    }, {"kind"}},
                    treesitter = {"lsp"}
                }
            }
        },

        sources = {
            default = {"lsp", "path", "lazydev", "snippets", "buffer"},
            providers = {
                lazydev = {
                    module = "lazydev.integrations.blink",
                    score_offset = 100
                }
            }
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning"
        },

        signature = {
            enabled = true
        }
    },
    opts_extend = {"sources.default"}
}
