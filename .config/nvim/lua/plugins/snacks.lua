return {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
        explorer = {
            auto_close = true,
            win = {
                list = {
                    keys = {
                        ["O"] = { "O", { "pick_win", "jump" }, mode = { "n", "i" } }, -- Key duplication is required
                    }
                }
            }
        },
        picker = {
            hidden = true,
            ignored = true,
        },
        image = {
            enabled = true,
        },
        scroll = {
            enabled = false,
        },
    },
}
