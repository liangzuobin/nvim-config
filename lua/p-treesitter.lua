require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "rust", "json", "regex", "vim", "go", "c", "python" },

  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = { "c", "lua" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {}
  }
}

require('template-string').setup({
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
  jsx_brackets = true,                                                              -- must add brackets to jsx attributes
  remove_template_string = false,                                                   -- remove backticks when there are no template string
  restore_quotes = {
    -- quotes used when "remove_template_string" option is enabled
    normal = [[']],
    jsx = [["]],
  },
})
