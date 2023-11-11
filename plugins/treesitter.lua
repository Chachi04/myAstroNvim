return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = {
    -- ensure_installed = { "lua" },
    context_commentstring = {
      enable = true,
    },
    -- indent = {
    --   enable = true,
    -- },
  },
}
