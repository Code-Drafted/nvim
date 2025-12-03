return {
  "stevearc/overseer.nvim",
  commit = "HEAD",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerClose" },
  opts = {
    strategy = { "toggleterm", use_shell = true },
    task_list = {
      direction = "bottom",
      bindings = {
        ["<CR>"] = "RunAction",
        ["q"] = "Close",
      },
    },
    templates = { "builtin" },
  },
  config = function(_, opts)
    require("overseer").setup(opts)

    local project_tasks_path = vim.fn.getcwd() .. "/.nvim/tasks.lua"
    if vim.fn.filereadable(project_tasks_path) == 1 then
      local ok, tasks = pcall(dofile, project_tasks_path)
      if ok then
        for _, task in ipairs(tasks) do
          require("overseer").register_template(task)
        end
      else
        vim.notify("Fout bij laden van .nvim/tasks.lua", vim.log.levels.ERROR)
      end
    end
  end,
  keys = {
    { "<leader>tr", "<cmd>OverseerRun<CR>", desc = "Run Task" },
    { "<leader>tt", "<cmd>OverseerToggle<CR>", desc = "Toggle Task List" },
  },
}
