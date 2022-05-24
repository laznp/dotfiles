local fname = vim.fn.expand("%:t:r")
local command = {}
local function apply()
    vim.cmd('!kubectl apply -f ' .. fname)
end

local function delete()
    vim.cmd('!kubectl delete -f ' .. fname)
end

local subcommands = {
    apply = apply,
    delete = delete,
}

function command.load_command(cmd, ...)
  local args = { ... }
  if next(args) ~= nil then
    subcommands[cmd](args[1])
  else
    subcommands[cmd]()
  end
end

return command
