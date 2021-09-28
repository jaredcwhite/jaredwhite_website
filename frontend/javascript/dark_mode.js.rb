set_switcher_icon = -> dark do
  light_icon = document.body.query_selector("switch-theme").get_attribute("light-icon")
  dark_icon = document.body.query_selector("switch-theme").get_attribute("dark-icon")
  icon_el = document.body.query_selector("switch-theme > sl-icon")

  icon_el.name = dark ? "weather/#{dark_icon}" : "weather/#{light_icon}"
end

activate_color_mode = -> scheme do
  if session_storage.get_item :color_scheme == :dark
    document.body.class_list.add "dark-mode"
    set_switcher_icon.(true)
    return
  end

  document.body.class_list.toggle "dark-mode", scheme === :dark
  set_switcher_icon.(scheme === :dark)
end

manually_toggle_mode = -> do
  if document.body.class_list.contains "dark-mode"
    session_storage.set_item :color_scheme, :light
    set_switcher_icon.(false)
  else
    session_storage.set_item :color_scheme, :dark
    set_switcher_icon.(true)
  end
  document.body.class_list.toggle "dark-mode"
end

if session_storage.get_item(:color_scheme) != :light && window.match_media("(prefers-color-scheme: dark)").matches
  activate_color_mode.(:dark)
  set_switcher_icon.(true)
end

window.match_media("(prefers-color-scheme: dark)").add_event_listener :change do |e|
  return if session_storage.get_item :color_scheme

  e.matches ? activate_color_mode.(:dark) : activate_color_mode.(:light)
end

document.body.add_event_listener :keydown do |e|
  manually_toggle_mode.() if e.key_code == 220
end

window.add_event_listener :DOMContentLoaded do
  document.query_selector("switch-theme").add_event_listener :click, manually_toggle_mode
  set_switcher_icon.(document.body.class_list.contains "dark-mode")
end

set_timeout 100 do
  document.body.class_list.add "mode-transitionable"
end
