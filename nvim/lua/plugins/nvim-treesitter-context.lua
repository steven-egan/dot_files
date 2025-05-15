return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin (Can be toggled later via :TSContextToggle)
            max_lines = 3, -- How many lines the context window should span
            multiline_threshold = 20,
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded
            mode = "cursor", -- Line used to calculate context (cursor or topline)
            separator = nil,
        })
    end,
}
