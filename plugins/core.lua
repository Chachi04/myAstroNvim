return {
    -- customize alpha options
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- customize the dashboard header
            opts.section.header.val = {
                -- " █████  ███████ ████████ ██████   ██████",
                -- "██   ██ ██         ██    ██   ██ ██    ██",
                -- "███████ ███████    ██    ██████  ██    ██",
                -- "██   ██      ██    ██    ██   ██ ██    ██",
                -- "██   ██ ███████    ██    ██   ██  ██████",
                "     ██ ██  █████   ██████  ██ ██  ██████ ",
                "     ██ ██ ██   ██ ██    ██ ██  █ ██      ",
                "     ██ ██ ███████ ██ ██ ██ ██     █████  ",
                "██   ██ ██ ██   ██  ██████  ██         ██ ",
                " █████  ██ ██   ██    ██    ██    ██████  ",
                " ",
                "     ███    ██ ██    ██ ██ ███    ███",
                "     ████   ██ ██    ██ ██ ████  ████",
                "     ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "     ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "     ██   ████   ████   ██ ██      ██",
            }

            return opts
        end,
    },
    -- You can disable default plugins as follows:
    -- { "max397574/better-escape.nvim", enabled = false },
    --
    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", { "javascriptreact" })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules(
                {
                    Rule("$", "$", { "tex", "latex" })
                        -- don't add a pair if the next character is %
                        :with_pair(
                            cond.not_after_regex "%%"
                        )
                        -- don't add a pair if  the previous character is xxx
                        :with_pair(
                            cond.not_before_regex("xxx", 3)
                        )
                        -- don't move right when repeat character
                        :with_move(
                            cond.not_before_text "$"
                        )
                        -- don't delete if the next character is xx
                        :with_del(
                            cond.not_after_regex "xx"
                        )
                        -- disable adding a newline when you press <cr>
                        :with_cr(cond.none()),
                },
                -- disable for .vim files, but it work for another filetypes
                Rule("a", "a", "-vim")
            )
        end,
    },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     opts = function()
    --         local cmp = require "cmp"
    --         local snip_status_ok, luasnip = pcall(require, "luasnip")
    --         local lspkind_status_ok, lspkind = pcall(require, "lspkind")
    --         if not snip_status_ok then return end
    --         local border_opts = {
    --             border = "single",
    --             winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    --         }
    --
    --         local function has_words_before()
    --             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --             return col ~= 0
    --                 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    --         end
    --
    --         return {
    --             enabled = function()
    --                 if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
    --                 return vim.g.cmp_enabled
    --             end,
    --             preselect = cmp.PreselectMode.None,
    --             formatting = {
    --                 fields = { "kind", "abbr", "menu" },
    --                 format = lspkind_status_ok and lspkind.cmp_format(astronvim.lspkind) or nil,
    --             },
    --             snippet = {
    --                 expand = function(args) luasnip.lsp_expand(args.body) end,
    --             },
    --             duplicates = {
    --                 nvim_lsp = 1,
    --                 luasnip = 1,
    --                 cmp_tabnine = 1,
    --                 buffer = 1,
    --                 path = 1,
    --             },
    --             confirm_opts = {
    --                 behavior = cmp.ConfirmBehavior.Replace,
    --                 select = false,
    --             },
    --             window = {
    --                 completion = cmp.config.window.bordered(border_opts),
    --                 documentation = cmp.config.window.bordered(border_opts),
    --             },
    --             mapping = {
    --                 ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    --                 ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    --                 ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    --                 ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    --                 ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    --                 ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    --                 ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    --                 ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    --                 ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    --                 ["<C-y>"] = cmp.config.disable,
    --                 ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    --                 ["<CR>"] = cmp.mapping.confirm { select = false },
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     elseif luasnip.expand_or_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     elseif has_words_before() then
    --                         cmp.complete()
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --                 ["<S-Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     elseif luasnip.jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --             },
    --             sources = cmp.config.sources {
    --                 -- { name = "copilot", priority = 1250 },
    --                 { name = "nvim_lsp", priority = 1000 },
    --                 { name = "luasnip", priority = 750 },
    --                 { name = "buffer", priority = 500 },
    --                 { name = "path", priority = 250 },
    --             },
    --         }
    --     end,
    -- },
    -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
    -- {
    --   "folke/which-key.nvim",
    --   config = function(plugin, opts)
    --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
    --     -- Add bindings which show up as group name
    --     local wk = require "which-key"
    --     wk.register({
    --       b = { name = "Buffer" },
    --     }, { mode = "n", prefix = "<leader>" })
    --   end,
    -- },
}
