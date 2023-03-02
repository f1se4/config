--  _                            ____             __ _
-- | |   _   _ _ __   __ _ _ __ / ___|___  _ __  / _(_) __ _
-- | |  | | | | '_ \ / _` | '__| |   / _ \| '_ \| |_| |/ _` |
-- | |__| |_| | | | | (_| | |  | |__| (_) | | | |  _| | (_| |
-- |_____\__,_|_| |_|\__,_|_|   \____\___/|_| |_|_| |_|\__, |
--                                                     |___/
--                                                 f1se4
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
--lvim.colorscheme = "gruvbox"

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["//"] = ":noh<cr>"
lvim.keys.normal_mode["<leader><leader>w"] = ":HopAnywhere<cr>"
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"


-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the karsers change this to a table of the ones you want
lvim.builtin.treesitter.enkure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "scala",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

local dap = require("dap")
        dap.adapters.python = {
            type = "executable",
            command = "/usr/bin/python3",
            args = {
                "-m",
                "debugpy.adapter",
              },
          }

        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = function()
                  if os.getenv("VIRTUAL_ENV") == nil then
                    return "/usr/bin/python3"
                  else
                    return os.getenv("VIRTUAL_ENV") .. "/bin/python3"
                  end
                end
              },
          }

-- **********************
-- Additional Plugins
-- **********************
 lvim.plugins = {
  {
    "morhetz/gruvbox"
  },
  {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.cmd "highlight default link gitblame SpecialComment"
    vim.g.gitblame_enabled = 0
  end,
},
  {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gdiffsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
    "GBrowse",
    "GRemove",
    "GRename",
    "Glgrep",
    "Gedit"
  },
  ft = {"fugitive"}
},
  {
  "phaazon/hop.nvim",
  event = "BufRead",
  config = function()
    require("hop").setup()
  end,
   },
  {
  "ggandor/lightspeed.nvim",
  event = "BufRead",
},
    {
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
  end,
  },
 }

 vim.api.nvim_create_autocmd("FileType", {
   pattern = "zsh",
   callback = function()
     -- let treesitter use bash highlight for zsh files as well
     require("nvim-treesitter.highlight").attach(0, "bash")
   end,
 })
--
