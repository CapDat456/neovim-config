-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "lua_ls", -- Lua lsp
  "html", -- Html lsp
  "emmet_ls", -- Emmet support
  "cssls", -- Css lsp
  "tsserver", -- JavaScript lsp
  "rome", -- JavaScript lsp
  "clangd", -- C, C++ lsp
  "bashls", -- Bash lsp
  "rust_analyzer", -- Rust lsp
  "jsonls", -- Json lsp
}
local lspconfig = require "lspconfig"
local opts = {}

require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "html", "emmet_ls", "cssls", "tsserver", "rome", "bashls", "rust_analyzer", "jsonls" },
}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
