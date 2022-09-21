-- This file contains basic global settings

local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands


-- Global Variables
g.mapleader = " "
g.maplocalleader = " "
g.timeoutlen = 1000


-- Global options
set.termguicolors = true -- Enable GUI colors for the terminal to get true color

-- setup undodir instead of swap file
set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. ".vim/undodir"
set.undofile = true

-- sync mac with vim clipboard
set.clipboard = set.clipboard + "unnamedplus" -- copy & paste

set.wrap = false -- don't automatically wrap on load
set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.number = true -- show line numbers
set.relativenumber = true -- show relative line number
set.incsearch = true -- incremental search
set.hlsearch = true -- highlighted search results
set.ignorecase = true -- ignore case sensetive while searching
set.smartcase = true
set.updatetime = 500 -- CursorHold interval
set.expandtab = true
set.softtabstop = 4
set.shiftwidth = 4 -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
set.tabstop = 4 -- spaces per tab
set.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
set.autoindent = true -- maintain indent of current line
set.shiftround = true
set.splitbelow = true -- open horizontal splits below current window
set.splitright = true -- open vertical splits to the right of the current window
set.laststatus = 2 -- always show status line
set.errorbells = false
set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")
set.colorcolumn = "80"

-- TODO: validate if I like these settings
set.list = false -- show whitespace
set.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "▷─", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  space = " "
}
set.fillchars = {
  diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = " " -- remove ugly vertical lines on window division
}
set.scrolloff = 1 -- when scrolling, keep cursor 1 lines away from screen border
set.sidescrolloff = 2 -- keep 30 columns visible left and right of the cursor at all times
set.backspace = "indent,start,eol" -- make backspace behave like normal again
set.mouse = "a" -- turn on mouse interaction
set.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
set.inccommand = "split" -- live preview of :s results
set.shell = "zsh" -- shell to use for `!`, `:!`, `system()` etc.

-- highlight on yank
exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
  augroup end
]],
  false
)

-- jump to the last position when reopening a file
cmd(
  [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]]
)

-- auto source vim
cmd([[
  augroup neovim
		autocmd!
		autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
	augroup end
]])

-- patterns to ignore during file-navigation
set.wildignore = set.wildignore + "*.o,*.rej,*.so"
-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])
-- faster scrolling
set.lazyredraw = true
-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
-- completion options
set.completeopt = "menuone,noselect,noinsert"

-- 2 spaces for selected filetypes
cmd([[ autocmd FileType xml,html,xhtml,css,scss,javascript,lua,dart,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 ]])
-- json
cmd([[ au BufEnter *.json set ai expandtab shiftwidth=2 tabstop=2 sta fo=croql ]])

