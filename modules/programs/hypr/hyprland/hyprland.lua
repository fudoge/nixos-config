----------------
-- Programs
----------------
---@diagnostic disable-next-line: undefined-global
local hl = hl

require("custom.rules")

local terminal = "ghostty"
local fileManager = "dolphin"
local brightnessctl = "@brightnessctl@"
local mainMod = "ALT"

----------------
-- Monitors
----------------
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1.0,
})

----------------
-- Autostart
----------------
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpanel")
	hl.exec_cmd("hyprpolkitagent")
	hl.exec_cmd("fcitx5 -d --replace")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("~/.local/bin/hypr-monitor-autoset.sh")
	hl.exec_cmd("~/.local/bin/hypr-monitor-listen.sh")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	hl.exec_cmd("hyprland.start", function()
		hl.exec_cmd("setpriv --ambient-caps -all --quickshell -c caelestia")
	end)
end)

----------------
-- Environment
----------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("ELECTRON_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
hl.env("QS_ICON_THEME", "hicolor")

----------------
-- Config
----------------
hl.config({
	input = {
		kb_layout = "us",
		kb_options = "korean:ralt_hangul",
	},

	decoration = {
		rounding = 12,
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
		},
	},

	misc = {
		allow_session_lock_restore = true,
	},
})

----------------
-- Keybinds
----------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("caelestia shell drawers toggle launcher"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("ghostty -e yazi"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("wlogout --buttons-per-row 3 --column-spacing 24 --row-spacing 24 --margin 260"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + C", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + A", hl.dsp.window.center())

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("~/.local/bin/screenshot-area.sh"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.local/bin/screenshot-screen.sh"))

-- Switch workspace
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

----------------
-- Media / Brightness
----------------
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightnessctl .. " -c backlight -e4 -n2 set +4320"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessctl .. " -c backlight -e4 -n2 set 4320-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

----------------
-- Window Rules
----------------
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Dolphin
hl.window_rule({
	match = { class = "^(org.kde.dolphin)$" },
	opacity = "0.92 0.88",
})

hl.window_rule({
	match = { class = "^(org.kde.dolphin)$" },
	float = true,
	center = true,
})

-- Spotify
hl.window_rule({
	match = { class = "^(spotify)$" },
	opacity = "0.90 0.85",
})
