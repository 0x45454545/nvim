vim.o.nu  = true
vim.o.rnu = true
vim.o.cul = true

vim.o.wrap = false
vim.o.list = true
vim.o.lcs  = "tab:>>,trail:·,lead:·,eol:$"

vim.o.gcr = "n-v-c-i:block"

vim.o.ts  = 4
vim.o.sts = 4
vim.o.sw  = 0
vim.o.et  = true

vim.o.is  = true
vim.o.hls = true

vim.o.tgc = true

vim.o.sh   = "pwsh -NoLogo"
vim.o.shcf = "-NoLogo -Command"
vim.o.sxq  = ""

vim.o.stl = "%#Directory#%f%*:%{&readonly ? &modified ? '%*' : '%%' : &modified ? '**' : '--'} %#Number#%4l%*:%#Number#%-4c%*%=[%#Keyword#%{&filetype}%*]%=%%%#Number#%-3p%*"

vim.keymap.set("n", "<Tab>", "<Cmd>bn<Cr>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>bp<Cr>")

vim.keymap.set("n", "J", "<Cmd>m +1<Cr>")
vim.keymap.set("n", "K", "<Cmd>m -2<Cr>")

vim.keymap.set("n", ":", "q:i")

vim.cmd [[ au CmdwinEnter * let &l:nu  = v:false
                         \| let &l:rnu = v:false
                         \| let &l:ls  = 0
                         \| resize 1 ]]

vim.cmd [[ au CmdwinLeave * let &l:ls = 3 ]]

vim.cmd [[ au FileType * lua pcall(vim.treesitter.start) ]]

local github = "https://www.github.com/"

local addons = {
    github .. "nvim-treesitter/nvim-treesitter",
    github .. "0x45454545/gruber-darker.nvim"
}

vim.pack.add(addons)

local gruber = require "gruber-darker"

gruber.load(gruber.style.modern)
