-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
local maps = { n = {}, i = {}, v = {}, t = {} }

if vim.fn.executable "mycli" == 1 then
    maps.n["<leader>ts"] = { function() utils.toggle_term_cmd "mycli" end, desc = "ToggleTerm mycli" }
end

maps.i["<c-c>"] = { "<esc>" }
maps.n["<c-c>"] = { "<esc>" }
maps.n["J"] = { "mzJ`z" }
-- maps.n["<C-d>"] = { "<C-d>zz" }
-- maps.n["<C-u>"] = { "<C-u>zz" }
-- maps.n["n"] = { "nzzzv" }
-- maps.n["N"] = { "Nzzzv" }

-- Better undo breaks
maps.i["<space>"] = { "<space><c-g>u" }
maps.i[","] = { ",<c-g>u" }
maps.i["."] = { ".<c-g>u" }
maps.i["!"] = { "!<c-g>u" }
maps.i["?"] = { "?<c-g>u" }

-- maps.n["<leader>pv"] = { vim.cmd.Ex, desc = "Open Netrw" }
maps.n["<leader>c"] = {
    function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
    end,
    desc = "Close buffer",
}

-- Line Swapping
maps.n["<A-j>"] = { "<cmd>m .+1<CR>==" }
maps.n["<A-k>"] = { "<cmd>m .-2<CR>==" }
maps.i["<A-j>"] = { "<Esc><cmd>m .+1<CR>==gi" }
maps.i["<A-k>"] = { "<Esc><cmd>m .-2<CR>==gi" }
maps.v["<A-j>"] = { ":m '>+1<CR>gv=gv" }
maps.v["<A-k>"] = { ":m '<-2<CR>gv=gv" }

-- Telescope
maps.n["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Telescope find_files" }
maps.n["<leader><leader>"] = { function() require("telescope.builtin").git_files() end, desc = "Telescope git_files" }

maps.n["<leader>u"] = { "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo tree" }

maps.n["<C-n>"] = { "<cmd>Neotree toggle<CR>", desc = "Toggle File Explorer" }

-- Comments
maps.n["<c-/>"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
}
maps.v["<c-/>"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
maps.n["<c-_>"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
}
maps.v["<c-_>"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }

-- Telescope
maps.n["<leader>/"] = { function() require("telescope.builtin").live_grep() end, desc = "Telescope live_grep" }
maps.n["<leader>fd"] = { require("telescope.builtin").lsp_definitions, desc = "Telescope lsp_definitions" }

-- Lsp
maps.n["gr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" }

return maps
-- return {
--   -- first key is the mode
--   n = {
--     -- second key is the lefthand side of the map
--     -- mappings seen under group name "Buffer"
--     ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
--     ["<leader>bD"] = {
--       function()
--         require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(
--           bufnr) end)
--       end,
--       desc = "Pick to close",
--     },
--     -- tables with the `name` key will be registered with which-key if it's installed
--     -- this is useful for naming menus
--     ["<leader>b"] = { name = "Buffers" },
--     -- quick save
--     -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
--   },
--   t = {
--     -- setting a mapping to false will disable it
--     -- ["<esc>"] = false,
--   },
-- }
