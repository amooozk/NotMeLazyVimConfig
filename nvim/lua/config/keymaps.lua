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

wk.register({
  ["<leader>"] = {
    k = {
      name = " NotMe KeyMaps",
      c = { "<cmd>lua Compile_code()<CR>", " Compile Code (clang++)" },
      r = { "<cmd>lua Run_code_with_file()<CR>", " Run Code with Input.txt-Output.txt (c/c++)" },
      d = { "<cmd>lua Debug_compile_code()<CR>", " Debug Compile Code" },
      h = { "<cmd>:Telescope themes<CR>", " Theme Switcher" },
      t = { "<cmd>:TransparentToggle<CR>", " Transparent Colorscheme Toggle" },
      z = { "<cmd>:ZenMode<CR>", "󰫫 Activate Zen Mode" },
    },
  },
})

wk.setup()
