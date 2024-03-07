local fname = vim.fn.expand("%:t:r")
local command = {}
local function compile()
    vim.cmd('!arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 ' .. fname)
end

local function upload()
    vim.cmd('!arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:nodemcuv2 ' .. fname)
end

local function flash()
    compile()
    upload()
end

local subcommands = {
    compile = compile,
    upload = upload,
    flash = flash
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
