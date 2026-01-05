-- TODO: split into modular files. See https://github.com/tduyng/nvim/tree/main/lua/config
--[[
    Keep all Lua modules in this order, whether inline here or broken out into separate files.
    require("config.options")
    require("config.keymaps")
    require("config.session")
    require("config.statusline")
    require("config.tabline")
    require("config.diagnostics")
    require("config.autocmds")
    require("config.lsp")
--]]

-- Options
require("config.options")
-- Keymaps
require("config.keymaps")
-- Auto Commands
require("config.autocmds")

-- ========================
-- LSP
-- ========================

-- LSP activations, autocmds, etc.
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local default_keymaps = {
  { keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
  { keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
  { keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
  { keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
  { keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
}

-- TODO: consider simplifying. Should only use blink.cmp
local completion = vim.g.completion_mode or "blink" -- or 'native'
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    if client then
      -- Built-in completion
      if completion == "native" and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end

      -- Inlay hints
      if client:supports_method("textDocument/inlayHints") then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, args.buf, {
          style = "background", -- 'background', 'foreground', or 'virtual'
        })
      end

      for _, km in ipairs(default_keymaps) do
        -- Only bind if there's no `has` requirement, or the server supports it
        if not km.has or client.server_capabilities[km.has] then
          vim.keymap.set(
            km.mode or "n",
            km.keys,
            km.func,
            { buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
          )
        end
      end
    end
  end,
})

-- Enable LSP servers
vim.lsp.enable({
  -- "basedpyright", -- Python
  -- "bashls", -- Bash/Shell
  "clangd", -- clangd for C/C++
  -- "jsonls", -- JSON
  "lua_ls", -- Lua
  -- "rust_analyser", -- Rust
  -- "zls", -- Zig
  -- "yamlls", -- YAML
})

if vim.g.lsp_on_demands then
  vim.lsp.enable(vim.g.lsp_on_demands)
end
