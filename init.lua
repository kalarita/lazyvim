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

-- init.lua 或者在你的配置文件中

-- 初始化 which-key 插件
require("which-key").setup({})

-- 定义一个函数来运行当前文件中的 Python 脚本，并显示输出结果
local function run_python_script()
  -- 获取当前缓冲区文件名
  local file = vim.fn.expand("%")

  -- 检查文件类型是否为 Python
  if vim.bo.filetype ~= "python" then
    vim.api.nvim_err_writeln("This command can only be run on Python files.")
    return
  end
  -- 运行 Python 脚本并捕获输出
  local handle = io.popen("python " .. file)
  local result = handle:read("*a")
  handle:close()
  -- 显示结果在浮动窗口中
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))

  local width = vim.o.columns
  local height = vim.o.lines
  local win_width = math.ceil(width * 0.8)
  local win_height = math.ceil(height * 0.8)
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
  }
  vim.api.nvim_open_win(buf, true, opts)
end

-- 使用 which-key 注册快捷键
local wk = require("which-key")

wk.register({
  r = {
    name = "Run",
    p = { run_python_script, "Run Python Script" },
  },
}, { prefix = "<leader>" })

-- 使用系统剪切板
vim.opt.clipboard = "unnamedplus"
