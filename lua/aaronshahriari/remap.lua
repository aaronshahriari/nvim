vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
vim.cmd("autocmd FileType netrw set nu")

-- Map these to move through splits
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")

-- Map to change split size
vim.keymap.set("n", "<Left>", "<C-w>3<")
vim.keymap.set("n", "<Right>", "<C-w>3>")
vim.keymap.set("n", "<Down>", "<C-w>3+")
vim.keymap.set("n", "<Up>", "<C-w>3-")

-- create splits
vim.keymap.set("n", "<leader>1", "<C-w>v")
vim.keymap.set("n", "<leader>2", "<C-w>s")

-- map all splits set equal
vim.keymap.set("n", "<leader>=", "<C-w>=")

-- Map <leader>-n to open a new tab
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [['_dP]])

-- flip flop visual line blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- get to normal mode in terminal
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]])

-- run tmux inside of vim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/tmux-sessionizer<CR>")

-- Define a function for creating a small terminal
-- entering the current directory of file you are inside
function Small_terminal()
    local current_directory = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(current_directory)
    vim.cmd("new")
    vim.cmd("wincmd J")
    vim.api.nvim_win_set_height(0, 12)
    vim.cmd("term")
    vim.api.nvim_feedkeys("a", "n", true)
end

-- Create a mapping for the small terminal function
vim.keymap.set("n", "<leader>st", ":lua Small_terminal()<CR>")

-- Define a function for creating a split terminal
-- opens in the directory entered before vim
function Split_terminal()
    local current_directory = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(current_directory)
    vim.cmd("new")
    vim.cmd("wincmd L")
    vim.cmd("wincmd =")
    -- vim.api.nvim_win_set_height(0, 12)
    vim.cmd("term")
    vim.api.nvim_feedkeys("a", "n", true)
end

-- Create a mapping for the small terminal function
vim.keymap.set("n", "<leader>t", ":lua Split_terminal()<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
