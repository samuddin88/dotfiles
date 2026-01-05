-- Installed as part of LLVM package. Use the default clangd executable on the PATH

---@type vim.lsp.Config
return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    'compile_commands.json',
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  }
}
