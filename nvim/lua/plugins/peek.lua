return {
	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	ft = { "markdown" },
	config = function()
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
}
