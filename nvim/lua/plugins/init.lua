-- Load colorscheme
--
--
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" }, { confirm = false })
vim.cmd.colorscheme("kanagawa")

-- Load blink.cmp
--
--
vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
})

-- Lazy load on first insert mode entry
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    require("blink.cmp").setup({
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
      },
      completion = {
        documentation = { auto_show = false },
      },
      -- Experimental signature help support
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end,
})

-- Load treesitter
--
--
require("plugins.treesitter")



