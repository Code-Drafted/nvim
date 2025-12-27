return {
  { "williamboman/mason.nvim", config = true },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_setup = true,
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },
    config = function()
      local dap = require("dap")

      vim.keymap.set("n", "<leader>bgn", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<leader>bgo", dap.step_over, { desc = "DAP Step Over" })

      vim.keymap.set("n", "<leader>bsi", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<leader>bso", dap.step_out, { desc = "DAP Step Out" })

      vim.keymap.set("n", "<leader>bnt", dap.toggle_breakpoint, { desc = "DAP Breakpoint" })
      vim.keymap.set("n", "<leader>bct", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP Conditional Breakpoint" })

      vim.keymap.set("n", "<leader>bst", dap.terminate, { desc = "DAP Terminate" })
      vim.keymap.set("n", "<leader>brp", dap.repl.open, { desc = "DAP REPL" })

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn" })

      local mason_root = vim.fn.stdpath("data") .. "/mason"
      local codelldb_exe = mason_root .. "/packages/codelldb/extension/adapter/codelldb"
      if vim.loop.os_uname().sysname:match("Windows") then
        codelldb_exe = codelldb_exe .. ".exe"
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_exe,
          args = { "--port", "${port}" },
        },
      }

      local function path_join(...)
        return table.concat({ ... }, sep)
      end

      local function file_exists(p)
        return (vim.uv or vim.loop).fs_stat(p) ~= nil
      end

      local function read_json_file(p)
        local ok, lines = pcall(vim.fn.readfile, p)
        if not ok or not lines then return nil end
        local text = table.concat(lines, "\n")
        local ok2, obj = pcall(vim.json.decode, text)
        if not ok2 then return nil end
        return obj
      end

      local function expand_preset_path(s, source_dir)
        if type(s) ~= "string" then return nil end
        s = s:gsub("%${sourceDir}", source_dir)
        s = s:gsub("%${workspaceFolder}", source_dir)
        return vim.fn.fnamemodify(s, ":p")
      end

      local function get_candidate_build_dirs(source_dir)
        local dirs = {}

        local presets_path = path_join(source_dir, "CMakePresets.json")
        if file_exists(presets_path) then
          local presets = read_json_file(presets_path)
          if presets and type(presets.configurePresets) == "table" then
            for _, p in ipairs(presets.configurePresets) do
              local bd = expand_preset_path(p.binaryDir, source_dir)
              if bd and bd ~= "" then
                table.insert(dirs, bd)
              end
            end
          end
        end

        local common = {
          path_join(source_dir, "build"),
          path_join(source_dir, "Build"),
          path_join(source_dir, "out", "build"),
          path_join(source_dir, "cmake-build-debug"),
          path_join(source_dir, "cmake-build-release"),
        }
        for _, d in ipairs(common) do
          table.insert(dirs, d)
        end

        local out_build_glob = vim.fn.glob(path_join(source_dir, "out", "build", "*"), 1, 1)
        for _, d in ipairs(out_build_glob) do
          table.insert(dirs, d)
        end

        local jet_glob = vim.fn.glob(path_join(source_dir, "cmake-build-*"), 1, 1)
        for _, d in ipairs(jet_glob) do
          table.insert(dirs, d)
        end

        local seen, uniq = {}, {}
        for _, d in ipairs(dirs) do
          d = vim.fn.fnamemodify(d, ":p")
          if d and d ~= "" and not seen[d] then
            seen[d] = true
            table.insert(uniq, d)
          end
        end
        return uniq
      end

      local function find_exes_in_dir(dir)
        local pattern
        if vim.loop.os_uname().sysname:match("Windows") then
          pattern = dir .. "/**/*.exe"
        else
          pattern = dir .. "/**/*"
        end
        local matches = vim.fn.glob(pattern, 1, 1)

        local filtered = {}
        for _, p in ipairs(matches) do
          if vim.loop.os_uname().sysname:match("Windows") then
            if not p:match("[/\\]CMakeFiles[/\\]") then
              table.insert(filtered, p)
            end
          else
            table.insert(filtered, p)
          end
        end
        return filtered
      end

      local function pick_cmake_executable()
        local source_dir = vim.fn.getcwd()
        local build_dirs = get_candidate_build_dirs(source_dir)

        local candidates = {}
        for _, d in ipairs(build_dirs) do
          if file_exists(d) then
            local exes = find_exes_in_dir(d)
            for _, e in ipairs(exes) do
              table.insert(candidates, vim.fn.fnamemodify(e, ":p"))
            end
          end
        end

        local seen, uniq = {}, {}
        for _, e in ipairs(candidates) do
          if not seen[e] then
            seen[e] = true
            table.insert(uniq, e)
          end
        end

        if #uniq == 0 then
          return vim.fn.input("Path to executable: ", source_dir .. "/", "file")
        end

        if #uniq == 1 then
          return uniq[1]
        end

        local choice = nil
        vim.ui.select(uniq, { prompt = "Select executable to debug:" }, function(item)
          choice = item
        end)

        local waited = 0
        while choice == nil and waited < 2000 do
          vim.wait(50)
          waited = waited + 50
        end

        return choice or uniq[1]
      end

      dap.configurations.cpp = {
        {
          name = "Launch (CMake auto-detect)",
          type = "codelldb",
          request = "launch",
          program = pick_cmake_executable,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

      vim.keymap.set("n", "<leader>bgu", dapui.toggle, { desc = "DAP UI Toggle" })
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = { commented = true },
  },
}

