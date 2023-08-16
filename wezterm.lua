local wezterm = require 'wezterm';

local mykeys = {}
for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(mykeys, {
    key=tostring(i),
    mods="ALT",
    action=wezterm.action{ActivateTab=i-1},
  })
end

table.insert(mykeys, {key = '[', mods = 'ALT', action = wezterm.action.ActivateTabRelative(-1)})
table.insert(mykeys, {key = ']', mods = 'ALT', action = wezterm.action.ActivateTabRelative(1)})
table.insert(mykeys, {key = '{', mods = 'ALT|SHIFT', action = wezterm.action.MoveTabRelative(-1)})
table.insert(mykeys, {key = '}', mods = 'ALT|SHIFT', action = wezterm.action.MoveTabRelative(1)})
table.insert(mykeys, {key = 'W', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true },})

local launch_menu = {}
local ssh_config_file = wezterm.home_dir .. "/.ssh/config"
local f = io.open(ssh_config_file)
if f then
	local line = f:read("*l")
	while line do
		if line:find("Host ") == 1 then
			local host = line:gsub("Host ", "")
			table.insert(
				launch_menu,
				{
					label = "SSH " .. host,
					args = {"tssh", host}
				}
			)
		end
		line = f:read("*l")
	end
	f:close()
end

local msys2_start_args = {
    "D:\\msys64\\msys2_shell.cmd",
    "-clang64"
}

local hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },

    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },

    -- file:// URI
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\bfile://\S*\b]],
      format = '$0',
    },

    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },

    -- Make task numbers clickable
    -- The first matched regex group is captured in $1.
    -- {
    --   regex = [[\b[tT](\d+)\b]],
    --   format = 'https://example.com/tasks/?t=$1',
    -- },

    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
    -- {
    --   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
    --   format = 'https://www.github.com/$1/$3',
    -- },
  }


return {
  keys = mykeys,
  font = wezterm.font_with_fallback({"JetBrains Mono NL"}),
  --font = wezterm.font_with_fallback({"VictorMono NF"}),
  hyperlink_rules = hyperlink_rules,
  -- color_scheme = "Blue Matrix",
  default_prog = {"pwsh.EXE"},
  font_size = 12.0,
  initial_rows = 40,
  initial_cols = 160,
  term = "xterm-256color",
  scrollback_lines = 35000,
  enable_scroll_bar = true,
  audible_bell = "Disabled",
  -- add_wsl_distributions_to_launch_menu = false,
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
  window_close_confirmation = 'NeverPrompt',
}