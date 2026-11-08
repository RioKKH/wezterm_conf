local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_domain = "WSL:Ubuntu"
config.ssh_domains = {
	{
		name = "ubuntu-server",
		remote_address = "192.168.10.200:10022",
		username = "rio",
		multiplexing = "None",
	},
}
config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }
-- config.leader = {key = 'a', mods = 'CTRL', timeout_milliseconds = 1000}

-- テーマ
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = 'rose-pine'

-- フォント
config.font = wezterm.font("HackGen Console NF")
config.font_size = 10.0

-- 余白（窮屈さを解消）
config.window_padding = { left = 12, right = 12, top = 10, bottom = 8 }

-- スクロールバー
config.enable_scroll_bar = true

-- タイトルバーを消してタブバーに統合
-- config.window_decorations = 'RESIZE'

-- タブバー
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- 透過+すりガラス
config.window_background_opacity = 0.95
config.text_background_opacity = 0.5
-- config.win32_system_backdrop = 'Acrylic'

-- 描画の滑らかさ
config.max_fps = 120
config.front_end = "WebGpu"

-- ベル設定
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 75,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 75,
	target = "CursorColor", -- カーソルだけ点滅。BackgroundColorなら画面全体
}
config.colors = {
	visual_bell = "#402020",
	scrollbar_thumb = "#3b4261", -- Tokyo Nightに合わせた色
}

config.keys = {
	-- ドメイン選択ランチャー
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "FUZZY|DOMAINS" }),
	},
	-- ペイン分割
	{
		key = "h",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Left" }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Down" }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Up" }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Right" }),
	},
	{
		key = "g",
		mods = "LEADER",
		action = act.PaneSelect,
	},
	-- ペイン移動
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT|ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT|ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT|ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	-- リサイズモードに入る
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
}

config.key_tables = {
	resize_pane = {
		-- リサイズ
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
		-- リサイズモードを抜ける
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
