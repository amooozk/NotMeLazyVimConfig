return {
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[
 ███▄    █  ▒█████  ▄▄▄█████▓ ███▄ ▄███▓▓█████     ▄████▄   ▒█████  ▓█████▄ ▓█████     ▄▄▄       ██▀███  ▓█████  ███▄    █  ▄▄▄      
 ██ ▀█   █ ▒██▒  ██▒▓  ██▒ ▓▒▓██▒▀█▀ ██▒▓█   ▀    ▒██▀ ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀    ▒████▄    ▓██ ▒ ██▒▓█   ▀  ██ ▀█   █ ▒████▄    
▓██  ▀█ ██▒▒██░  ██▒▒ ▓██░ ▒░▓██    ▓██░▒███      ▒▓█    ▄ ▒██░  ██▒░██   █▌▒███      ▒██  ▀█▄  ▓██ ░▄█ ▒▒███   ▓██  ▀█ ██▒▒██  ▀█▄  
▓██▒  ▐▌██▒▒██   ██░░ ▓██▓ ░ ▒██    ▒██ ▒▓█  ▄    ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄    ░██▄▄▄▄██ ▒██▀▀█▄  ▒▓█  ▄ ▓██▒  ▐▌██▒░██▄▄▄▄██ 
▒██░   ▓██░░ ████▓▒░  ▒██▒ ░ ▒██▒   ░██▒░▒████▒   ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒    ▓█   ▓██▒░██▓ ▒██▒░▒████▒▒██░   ▓██░ ▓█   ▓██▒
░ ▒░   ▒ ▒ ░ ▒░▒░▒░   ▒ ░░   ░ ▒░   ░  ░░░ ▒░ ░   ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░    ▒▒   ▓▒█░░ ▒▓ ░▒▓░░░ ▒░ ░░ ▒░   ▒ ▒  ▒▒   ▓▒█░
░ ░░   ░ ▒░  ░ ▒ ▒░     ░    ░  ░      ░ ░ ░  ░     ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░     ▒   ▒▒ ░  ░▒ ░ ▒░ ░ ░  ░░ ░░   ░ ▒░  ▒   ▒▒ ░
   ░   ░ ░ ░ ░ ░ ▒    ░      ░      ░      ░      ░        ░ ░ ░ ▒   ░ ░  ░    ░        ░   ▒     ░░   ░    ░      ░   ░ ░   ░   ▒   
         ░     ░ ░                  ░      ░  ░   ░ ░          ░ ░     ░       ░  ░         ░  ░   ░        ░  ░         ░       ░  ░
                                                  ░                  ░                                                               
]]

      logo = string.rep("\n", 5) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = LazyVim.pick(),                                    desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = function()
              vim.fn.execute("cd ~/NotMeCodeByteBunker")
              vim.cmd("Neotree filesystem")
            end, desc = "  Open NotMeCodeByteBunker", icon = "󱂵", key = "w" },
          { action = [[lua LazyVim.pick.config_files()()]],                 desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            return { " Changing the Config without NotMe's permission on NotMe's Machine is strictly prohibited " }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
