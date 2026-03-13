return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		cmd = { "CopilotChatOpen", "CopilotChat" },
		opts = {
			model = "gpt-4.1",
			temperature = 0.1,
			window = {
				layout = "vertical",
				width = 0.3,
			},
			headers = {
				user = " Daya",
				assistant = " Copilot",
				tools = "󱁤",
			},
		},
	},
}
