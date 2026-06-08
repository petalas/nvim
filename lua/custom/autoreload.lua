local M = {}

local uv = vim.uv or vim.loop
local state_key = '__custom_nvim_config_autoreload'

local config_dir = vim.fs.normalize(vim.fn.stdpath 'config')
local init_file = vim.fs.normalize(config_dir .. '/init.lua')
local lua_dir = vim.fs.normalize(config_dir .. '/lua')

local function normalize(path)
  return vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
end

local function is_config_file(path)
  path = normalize(path)
  return path == init_file or (path:sub(1, #lua_dir + 1) == lua_dir .. '/' and path:match '%.lua$')
end

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = 'nvim config' })
end

local function stop_state()
  local state = rawget(_G, state_key)
  if not state then
    return
  end

  if state.timer then
    pcall(state.timer.stop, state.timer)
    pcall(state.timer.close, state.timer)
  end

  for _, watcher in ipairs(state.watchers or {}) do
    pcall(watcher.stop, watcher)
    pcall(watcher.close, watcher)
  end

  rawset(_G, state_key, nil)
end

local function collect_watch_dirs()
  local dirs = { config_dir }

  local function scan(dir)
    local handle = uv.fs_scandir(dir)
    if not handle then
      return
    end

    while true do
      local name, filetype = uv.fs_scandir_next(handle)
      if not name then
        break
      end

      if filetype == 'directory' then
        local child = vim.fs.normalize(dir .. '/' .. name)
        dirs[#dirs + 1] = child
        scan(child)
      end
    end
  end

  scan(lua_dir)
  return dirs
end

local function reload_config(changed_file)
  if vim.g.custom_config_reloading then
    return
  end

  vim.g.custom_config_reloading = true
  local ok, err = pcall(function()
    vim.cmd('silent source ' .. vim.fn.fnameescape(init_file))
  end)
  vim.g.custom_config_reloading = false

  if ok then
    notify('Reloaded config: ' .. vim.fn.fnamemodify(changed_file or init_file, ':~:.'))
  else
    notify('Config reload failed: ' .. tostring(err), vim.log.levels.ERROR)
  end
end

function M.setup()
  stop_state()

  local state = {
    timer = assert(uv.new_timer()),
    watchers = {},
    pending_file = nil,
  }
  rawset(_G, state_key, state)

  local function schedule_reload(path)
    if path and not is_config_file(path) then
      return
    end

    state.pending_file = path or init_file
    state.timer:stop()
    state.timer:start(100, 0, function()
      local changed_file = state.pending_file
      state.pending_file = nil
      vim.schedule(function()
        reload_config(changed_file)
      end)
    end)
  end

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('custom-config-autoreload', { clear = true }),
    pattern = '*',
    callback = function(event)
      if is_config_file(event.file) then
        schedule_reload(event.file)
      end
    end,
    desc = 'Reload Neovim config after saving config files',
  })

  for _, dir in ipairs(collect_watch_dirs()) do
    local watcher = uv.new_fs_event()
    if watcher then
      local ok = watcher:start(dir, {}, function(err, filename)
        if err then
          vim.schedule(function()
            notify('Config watcher failed: ' .. tostring(err), vim.log.levels.ERROR)
          end)
          return
        end

        local path = filename and vim.fs.normalize(dir .. '/' .. filename) or nil
        schedule_reload(path)
      end)

      if ok then
        state.watchers[#state.watchers + 1] = watcher
      else
        watcher:close()
      end
    end
  end
end

return M
