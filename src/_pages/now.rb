###ruby
{
  layout: :now,
  title: I18n.t("destinations.now.name"),
  # BUG…this shouldn't be necessary:
#  permalink: "/now.html",
  subtitle: "What I’m focused on right now.",
  template_engine: "ruby"
}
###

# send this off to the layout for processing:
resource.data.current_now_entry = collections.now_entries.resources.first
