return {
  "saghen/blink.cmp",
  version = "1.*",

  lazy = true,
  event = { "BufReadPost", "BufNewFile" },

  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    completion = {
      keyword = { range = "full" },
      accept = { auto_brackets = { enabled = true } },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        auto_show = true,
        border = "single",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 2000 },
      ghost_text = { enabled = false },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    appearance = { nerd_font_variant = "normal" },
  },
}
