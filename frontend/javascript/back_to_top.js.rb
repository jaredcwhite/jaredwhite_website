class BackToTopElement < HTMLElement
  def connected_callback()
    @previous_scroll_position = window.scroll_y
    @scroller = scroll_handler
    document.add_event_listener :scroll, @scroller
    self.add_event_listener :click do
      window.scroll_to top: 0, behavior: :smooth
    end
  end

  def disconnected_callback()
    document.remove_event_listener :scroll, @scroller
  end

  def scroll_handler(_event)
    new_position = window.scroll_y

    window.request_animation_frame do
      if new_position > 400 && new_position < @previous_scroll_position - 100
        @previous_scroll_position = new_position
        self.remove_attribute :active
      elsif new_position > @previous_scroll_position + 100
        @previous_scroll_position = new_position
        self.set_attribute :active, true
      end
    end
  end
end

custom_elements.define "back-to-top", BackToTopElement
