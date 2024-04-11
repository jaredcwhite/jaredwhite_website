###ruby
front_matter do
  layout :now
  title I18n.t("destinations.now.name")
  subtitle "What I’m focused on right now."
end
###

# send this off to the layout for processing:
resource.data.current_now_entry = collections.now_entries.resources.first
