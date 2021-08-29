# Handle responsive sidebar taps outside the sidebar
window.add_event_listener :DOMContentLoaded do
  document.query_selector("#nav-tab").add_event_listener :click do |e|
    tab = e.current_target
    if tab.parent_node.get_attribute(:open) === ""
      tab.parent_node.remove_attribute :open
      document.query_selector("main-content").remove_attribute :underneath
    else
      tab.parent_node.set_attribute :open, ""
      document.query_selector("main-content").set_attribute :underneath, ""
    end
  end
  document.body.add_event_listener :click do |e|
    sidebar = document.query_selector "responsive-sidebar"
    if sidebar.get_attribute(:open) === "" && !e.target.closest("responsive-sidebar")
      sidebar.remove_attribute :open
      document.query_selector("main-content").remove_attribute :underneath
    end
  end
end