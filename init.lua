-- leader
vim.g.mapleader = " "

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- highlight line number
vim.opt.cursorline = true

-- no line wrapping
vim.opt.wrap = false

-- four spaces for tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- highlight incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- more colors
vim.opt.termguicolors = true

-- pwsh as cmdline/shell
vim.opt.shell = "pwsh -NoLogo"
vim.opt.shellcmdflag = "-NoLogo -Command"
vim.opt.shellxquote = ""

-- le snake motions
vim.opt.iskeyword:remove("_")

-- mappings
local map = vim.keymap.set
local on = vim.api.nvim_create_autocmd

-- better cmd
map("n", ":", "q:i")

-- buffer navigation
map("n", "<Leader>t", ":b#<CR>")
map("n", "<Tab>", ":bn<CR>")
map("n", "<S-Tab>", ":bp<CR>")

-- visual line move
map("n", "J", ":m +1<CR>")
map("n", "K", ":m -2<CR>")

-- surround selection
local function surround(l, r) return "<Esc>`>a" .. r .. "<Esc>`<i" .. l .. "<Esc>lm<`>lm>gv" end

map("x", "<Leader>s(", surround("(", ")"))
map("x", "<Leader>s{", surround("{", "}"))
map("x", "<Leader>s[", surround("[", "]"))
map("x", "<Leader>s<", surround("<", ">"))
map("x", '<Leader>s"', surround('"', '"'))
map("x", "<Leader>s'", surround("'", "'"))

-- unsurround
local function unsurround(l) return "va" .. l .. "<Esc>xF" .. l .. "x" end

map("n", "<Leader>S(", unsurround("("))
map("n", "<Leader>S{", unsurround("{"))
map("n", "<Leader>S[", unsurround("["))
map("n", "<Leader>S<", unsurround("<"))
map("n", '<Leader>S"', unsurround('"'))
map("n", "<Leader>S'", unsurround("'"))

-- terminal qol
map("t", "<Esc>", "<C-\\><C-n>")

-- addons
local function github(link) return "https://www.github.com/" .. link end

local addons = {
    github ("nvim-treesitter/nvim-treesitter"),
    github ("0x45454545/gruber-darker.nvim"),
}

vim.pack.add(addons)

-- tree sitter
local ts = require "nvim-treesitter"

local languages = { "c", "lua", "python", "haskell", "ocaml" }

ts.install(languages)

-- v:lua needs it
_G.ts_indent = ts.indentexpr

local function load_tree_sitter(args)

    local success, _ = pcall(vim.treesitter.start, args.buf)

    if success then 
        vim.bo[args.buf].indentexpr = "v:lua.ts_indent()"
    end

end

on("FileType", { callback = load_tree_sitter })

-- gruber darker
local gruber = require "gruber-darker"

gruber.load(gruber.style.modern)
