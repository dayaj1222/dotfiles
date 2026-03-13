vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim", "Snacks", "snacks" },
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly", -- or "workspace"
				typeCheckingMode = "basic", -- or "strict"
			},
		},
	},
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = false, -- Changed
				loadOutDirsFromCheck = true,
			},
			diagnostics = {
				enable = true,
				experimental = {
					enable = false,
				},
			},
			procMacro = {
				enable = true,
				attributes = {
					enable = false,
				},
			},
			inlayHints = {
				typeHints = true,
				parameterHints = true,
				chainingHints = true,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go" },
	root_markers = {
		"go.mod",
		".git",
	},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	root_markers = {
		"compile_commands.json",
		"compile_flags.txt",
		"Makefile",
		".git",
	},
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})

vim.lsp.enable({
	"basedpyright",
	"ts_ls",
	"lua_ls",
	"cssls",
	"html",
	"tailwindcss",
	"rust_analyzer",
	"clangd",
	"bash-ls",
	"gopls",
})

vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			if diagnostic.code == 80001 then
				return "" -- Return empty string instead of nil
			end
			return diagnostic.message
		end,
	},
})
