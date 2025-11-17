return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope", -- Load when any Telescope command is used
	keys = {
		{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<M-l>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<M-e>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<M-l>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
		})
	end,
}
