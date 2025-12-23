local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local fn  = vim.fn

local map = vim.keymap.set

opt.relativenumber = true
opt.wrap           = false
opt.cursorline     = true
opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.incsearch      = true
opt.hlsearch       = true
opt.termguicolors  = true
opt.splitbelow     = true
opt.splitright     = true

-- Disable arrow keys.
map({'n', 'i'}, '<Left>', '<Nop>')
map({'n', 'i'}, '<Up>', '<Nop>')
map({'n', 'i'}, '<Right>', '<Nop>')
map({'n', 'i'}, '<Down>', '<Nop>')

-- Disable unit horizontal movement.
map('n', 'h', '<Nop>')
map('n', 'l', '<Nop>')

-- Terminal Mappings.
map('t', '<Esc>', '<C-\\><C-n>')

-- Fix terminal on windows.
opt.shell = 'pwsh.exe'

-- Clean terminal buffer.
function cleanterm()
    opt.relativenumber       = false
    vim.opt_local.statusline = "term:" .. fn.fnamemodify(vim.o.shell, ":r")
end

api.nvim_create_autocmd("TermOpen", { callback = cleanterm })

require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "luau", "python", "haskell" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true }
}

require('onedarkpro').setup {
    styles = {
        types        = "NONE",
        numbers      = "NONE",
        strings      = "NONE",
        comments     = "NONE",
        keywords     = "NONE",
        constants    = "NONE",
        functions    = "NONE",
        operators    = "NONE",
        variables    = "NONE",
        conditionals = "NONE",
        virtual_text = "NONE",
    },
    highlights = {
        EndOfBuffer = { fg = "${purple}" }
    },
    plugins = {
        treesitter = true
    },
    options = {
        italic = false,
        cursorline = true
    }
}

require('colorizer').setup()

cmd [[ colorscheme onedark ]]

-- [[ Ensure packer ]]
local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        cmd [[ packadd packer.nvim ]]

        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'olimorris/onedarkpro.nvim'

    use 'norcalli/nvim-colorizer.lua'

    if packer_bootstrap then
        require('packer').sync()
    end

end)
