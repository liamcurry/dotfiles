return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
        opts.right = opts.right or {}
        table.insert(opts.right, {
            ft = "Avante",
            title = "Avante",
            size = { width = 50 },
        })
    end
}
