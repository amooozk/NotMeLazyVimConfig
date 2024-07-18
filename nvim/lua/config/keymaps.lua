-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

function Compile_code()
  vim.cmd("w")

  local file_name = vim.fn.expand("%:r")
  local out_file = file_name .. ".out"
  local command = "clang++ " .. file_name .. ".cpp -o " .. out_file

  local success = vim.fn.system(command)

  print(success)
end

function Debug_compile_code()
  vim.cmd("w")

  local file_name = vim.fn.expand("%:r")
  local out_file = file_name .. ".debug"
  local command = "clang++ -g " .. file_name .. ".cpp -o " .. out_file

  local success = vim.fn.system(command)

  print(success)
end

function Run_code_with_file()
  local file_name = vim.fn.expand("%:r")
  local executable = file_name .. ".out"
  local location = vim.fn.expand("%:p:h")
  local input_file = location .. "/INPUT.TXT"
  local output_file = location .. "/OUTPUT.TXT"

  local command = executable .. "<" .. input_file .. ">" .. output_file
  vim.cmd("! " .. command)
end

wk.add({
  { "<leader>k", group = "NotMe KeyMaps", icon = "" },
  { "<leader>kc", "<cmd>lua Compile_code()<CR>", desc = "Compile Code (clang++)", icon = "" },
  { "<leader>kd", "<cmd>lua Debug_compile_code()<CR>", desc = "Debug Compile Code", icon = "" },
  { "<leader>kh", "<cmd>:Telescope themes<CR>", desc = "Theme Switcher", icon = "" },
  {
    "<leader>kr",
    "<cmd>lua Run_code_with_file()<CR>",
    desc = " Run Code with Input.txt-Output.txt (c/c++)",
    icon = "",
  },
  { "<leader>kt", "<cmd>:TransparentToggle<CR>", desc = "Transparent Colorscheme Toggle", icon = "" },
  { "<leader>ky", ":<C-u>'<,'>w !clip.exe<CR>", desc = "Copy to Windows Clipboard", icon = "󱉬", mode = "v" },
  { "<leader>kz", "<cmd>:ZenMode<CR>", desc = "Activate Zen Mode", icon = "󰫫" },
})

wk.setup()

-- vim.api.nvim_set_keymap("v", "<leader>ky", ":<C-u>'<,'>w !clip.exe<CR>", { noremap = true, silent = true })
