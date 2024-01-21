local h = require "null-ls.helpers"
local methods = require "null-ls.methods"

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

-- local notify = vim.notify
-- vim.notify = function(msg, ...)
--     if
--         msg:match "warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
--     then
--         return
--     end
--     vim.cmd [[echol msg]]
--     return notify(msg, ...)
-- end

return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require "null-ls"

        -- Check supported formatters and linters
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        config.sources = {
            -- Set a formatter
            null_ls.builtins.formatting.stylua, -- lua
            null_ls.builtins.formatting.prettier, -- javascript, typescript, vue, svelte, jsx, tsx, html, css, json, yaml, markdown
            null_ls.builtins.formatting.black, -- python
            null_ls.builtins.formatting.clang_format.with {
                extra_args = { "--style=file:/home/chachi/.config/nvim/lua/user/.clang-format" },
                disabled_filetypes = { "cs" },
            }, -- C, C++, java
            -- null_ls.builtins.formatting.csharpier, -- C#
            null_ls.builtins.formatting.blade_formatter, -- Laravel Blade
            null_ls.builtins.formatting.rustfmt, -- Rust

            null_ls.builtins.completion.luasnip, -- LuaSnip
        }
        return config -- return final config table
    end,
}
