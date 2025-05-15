return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            current_line_blame = true, -- inline blame
            current_line_blame_opts = {
                delay = 500,
                virt_text_pos = "eol", -- or 'right_align' or 'overlay'
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        })
    end,
}
