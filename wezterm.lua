local wezterm = require 'wezterm';

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(launch_menu, {
    label = "PowerShell",
    args = {"powershell.exe", "-NoLogo"},
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
    local year = vsvers:gsub("Microsoft Visual Studio/", "")
    table.insert(launch_menu, {
      label = "x64 Native Tools VS " .. year,
      args = {"cmd.exe", "/k", "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat"},
    })
  end
end
return {
  font = wezterm.font_with_fallback({"JetBrains Mono","DengXian"}),
  color_scheme = "Blue Matrix",
  default_prog = {"D:\\programe\\powershell\\7\\pwsh.EXE"},
  font_size = 14.0,
  initial_rows = 35,
  initial_cols = 125,
  term = "xterm-256color",
  scrollback_lines = 35000,
  add_wsl_distributions_to_launch_menu = false,
  -- window_background_image = "D:\\jiaxi\\.config\\wezterm\\wezbg.jpg",
  -- window_background_image_hsb = {
    -- -- Darken the background image by reducing it to 1/3rd
    -- brightness = 0.3,

    -- -- You can adjust the hue by scaling its value.
    -- -- a multiplier of 1.0 leaves the value unchanged.
    -- hue = 1.0,

    -- -- You can adjust the saturation also.
    -- saturation = 1.0,
  -- },
  launch_menu = launch_menu,
  window_close_confirmation = 'NeverPrompt'
}