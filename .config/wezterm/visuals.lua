local module = {}

function module.apply_to_config(config)
	config.color_scheme = "nightfox"
	config.font_size = 16.0
	config.hide_tab_bar_if_only_one_tab = true
	config.enable_tab_bar = false
	config.macos_window_background_blur = 10
	config.window_background_opacity = 0.95
	config.window_decorations = "RESIZE"
end

return module
