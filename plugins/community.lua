return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of imporing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
    { import = "astrocommunity.completion.copilot-lua" },
    {
        -- further customize the options set by the community
        "copilot.lua",
        opts = {
            suggestion = {
                keymap = {
                    accept = "<C-l>",
                    accept_word = false,
                    accept_line = false,
                    next = "<C-.>",
                    prev = "<C-,>",
                    dismiss = "<C-]>",
                },
            },
        },
    },
    { import = "astrocommunity.completion.copilot-lua-cmp" },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require "cmp"
            opts.mapping["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }
            opts.mapping["<C-c>"] = nil
            return opts
        end,
    },
    { import = "astrocommunity.colorscheme.catppuccin" },
    -- { import = "astrocommunity.editing-support.telescope-undo-nvim" },
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    -- { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
    { import = "astrocommunity.pack.java" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.php" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.motion.nvim-surround" },
    { import = "astrocommunity.syntax.hlargs-nvim" },
    { import = "astrocommunity.markdown-and-latex.vimtex" },
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_compile = false
            local toggle_latex_compile = function()
                vim.g.tex_compile = not vim.g.tex_compile
                if vim.g.tex_compile then
                    vim.cmd ":VimtexCompile"
                else
                    vim.cmd ":VimtexStopAll"
                    vim.cmd ":VimtexClean"
                end
            end

            vim.g.vimtex_view_general_viewer = "evince"

            -- vim.keymap.set("n", "<f3>", toggle_latex_compile, { noremap = true, silent = true })
            vim.api.nvim_create_augroup("Latex", { clear = true })
            vim.api.nvim_create_autocmd("BufEnter", {
                desc = "Compile latex on save",
                pattern = "*.tex",
                group = "Latex",
                callback = function()
                    vim.keymap.set("n", "<f3>", toggle_latex_compile, { noremap = true, silent = true, buffer = true })
                end,
            })

            vim.api.nvim_create_augroup("VimTex", { clear = true })
            vim.api.nvim_create_autocmd("BufReadPre", {
                desc = "Set vimtex main file",
                pattern = "*.tex",
                group = "VimTex",
                callback = function() vim.g.vimtex_main = vim.fn.expand "%:p" end,
            })
        end,
    },
}
