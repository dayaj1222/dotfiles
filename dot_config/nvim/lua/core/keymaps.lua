vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- Exit insert more
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Window navigation


vim.keymap.set("n", "<leader>o", "<cmd>b#<CR>", { desc = "󰮲 Switch to alternate buffer" })

-- Delete without yanking
vim.keymap.set("v", "x", '"_d', { desc = "Delete without yanking" })

-- Mini files
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "󰙅 File Explorer" })

-- Copilot Chat keymaps
local copilot_keymaps = {
	{ { "n", "v" }, "<leader>cc", ":CopilotChat ", " Copilot Chat" },
	{ { "n", "v" }, "<leader>co", ":CopilotChatOpen<CR>", " Open Copilot Chat" },
	{ "n", "<leader>cx", ":CopilotChatClose<CR>", " Close Copilot Chat" },
	{ "n", "<leader>ct", ":CopilotChatToggle<CR>", " Toggle Copilot Chat" },
	{ "n", "<leader>cs", ":CopilotChatStop<CR>", " Stop Copilot Chat output" },
	{ "n", "<leader>cr", ":CopilotChatReset<CR>", " Reset Copilot Chat window" },
	{ "n", "<leader>cp", ":CopilotChatPrompts<CR>", " View Copilot Chat prompts" },
	{ "n", "<leader>cm", ":CopilotChatModels<CR>", " View Copilot Chat models" },
	{ "n", "<leader>cv", ":CopilotChatSave ", " Save Copilot Chat history" },
	{ "n", "<leader>cl", ":CopilotChatLoad ", " Load Copilot Chat history" },
}

for _, map in ipairs(copilot_keymaps) do
	vim.keymap.set(map[1], map[2], map[3], { desc = map[4] })
end

vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap)", { desc = "󰄮 Leap forward (current window)" })
vim.keymap.set("n", "F", "<Plug>(leap-from-window)", { desc = "󰄮 Leap across windows" })
