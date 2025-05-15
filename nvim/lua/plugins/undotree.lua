return {
	"mbbill/undotree",
	lazy = false,
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_SplitWidth = 40
	end,
}
