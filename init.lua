-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
})

-- 使用系统剪切板
vim.opt.clipboard = "unnamedplus"

-- 使用系统剪切板
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })

-- 引入 lspconfig
local lspconfig = require("lspconfig")

-- 配置 Ruff
lspconfig.ruff.setup({
  cmd = { "ruff-lsp" },
  settings = {
    -- 你的其他 Ruff 配置
  },
  -- 使用 root_pattern 查找最近的 pyproject.toml 文件
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname)
      or lspconfig.util.root_pattern("pyproject.toml")(fname)
      or lspconfig.util.path.dirname(fname)
  end,
})

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
})
