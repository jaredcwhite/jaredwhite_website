class CategoryIndicatorComponent < Bridgetown::Component
  def initialize(category: nil, destination: nil)
    @category, @destination = category, destination

    raise "Component must be given either a category or a destination" if @category.nil? && @destination.nil?
  end
end