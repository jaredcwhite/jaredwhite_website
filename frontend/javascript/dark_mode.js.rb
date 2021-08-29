activate_color_mode = -> scheme do
  document.body.class_list.toggle "dark-mode", scheme === :dark
end

activate_color_mode.(:dark) if window.match_media("(prefers-color-scheme: dark)").matches  

window.match_media("(prefers-color-scheme: dark)").add_event_listener :change do |e|
  e.matches ? activate_color_mode.(:dark) : activate_color_mode.(:light)
end
