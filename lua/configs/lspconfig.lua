-- Suppress lspconfig deprecation warning for nvim 0.11+
-- TODO: migrate to vim.lsp.config when NvChad updates
local orig_deprecate = vim.deprecate
vim.deprecate = function() end

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      -- Limit diagnostics to reduce log size
      if result and result.diagnostics then
        local max_diagnostics = 100
        if #result.diagnostics > max_diagnostics then
          result.diagnostics = vim.list_slice(result.diagnostics, 1, max_diagnostics)
        end
      end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
}


lspconfig.gopls.setup {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
    cnd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    autostart = true,  -- Explicitly enable autostart
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                nilness = true,
            },
            staticcheck = true,
        },
    },
}


lspconfig.terraformls.setup {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
  root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}


-- opa is not a built-in lspconfig server, register it as a custom config
local lspconfig_configs = require("lspconfig.configs")
if not lspconfig_configs.opa then
  lspconfig_configs.opa = {
    default_config = {
      cmd = { "opa", "lsp" },
      filetypes = { "rego" },
      root_dir = lspconfig.util.root_pattern(".git", "."),
    },
  }
end

lspconfig.opa.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- pyright (moved from init.lua)
lspconfig.pyright.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}

-- Restore vim.deprecate for other warnings
vim.deprecate = orig_deprecate
