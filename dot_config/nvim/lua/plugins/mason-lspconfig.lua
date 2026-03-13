return {
	"mason-org/mason-lspconfig.nvim",
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"lua_ls",
			"rust_analyzer",
			"biome",
			"basedpyright",
			"ts_ls",
			"stylua",
			"tailwindcss",
			"cssls",
			"html",
			"bashls",
			"clangd",
			"gopls",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
