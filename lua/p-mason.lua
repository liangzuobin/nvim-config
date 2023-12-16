require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'gopls',
    'pyright',
    'clangd',
    'rust_analyzer',
    'lua_ls',
  },
  automatic_installation = true,
})

local on_attach = function(_, bufnr)
  -- format on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    callback = function()
      -- vim.lsp.buf.format()
      vim.lsp.buf.format { async = true }
    end
  })
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_config = {
  capabilities = capabilities,
  group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
  on_attach = function(_, bufnr)
    on_attach(_, bufnr)
  end
}

require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup(lsp_config)
  end,
  ["gopls"] = function()
    require('lspconfig').gopls.setup(vim.tbl_extend('force', lsp_config, {
      settings = {
        gopls = {
          gofumpt = true,
        },
      },
    }))
  end,
  ["clangd"] = function()
    require('lspconfig').clangd.setup(vim.tbl_extend('force', lsp_config, {
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    }))
  end,
  ["pyright"] = function()
    -- require('lspconfig').pyright.setup({})
    require('lspconfig').pyright.setup(lsp_config)
  end,
})


-- vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
-- vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
-- vim.keymap.set('n', '<leader>r', '<cmd>TypescriptRemoveUnused<cr>')
