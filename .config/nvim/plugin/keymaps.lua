local set = vim.keymap.set

-- Prevent continue comment on new line
vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = "*", command = [[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]] }
)
vim.opt.wildignore = "*/.git/*,*/.DS_Store/*,*/target/*,*/node_modules/*"
vim.opt.expandtab = true

-- stay in indent mode only
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Move lines by selecting
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep yaa head straight
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- Navigate with Netrw
set("n", "<leader>n", vim.cmd.Ex, { desc = "Open [N]etrw" })

-- Prime said this is greatest remap ever
set("x", "<leader>p", [["_dP]])

-- Next greatest reamap
set({ "n", "v" }, "<leader>d", [["_d]])

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
set("n", "[d", function()
    vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Go to previous [D]iagnostic message" })

set("n", "]d", function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Go to next [D]iagnostic message" })

set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- Disable arrow keys in normal mode
set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
