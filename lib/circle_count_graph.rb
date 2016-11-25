require_relative 'count_graph'

class CircleCountGraph < CountGraph

  def draw_item(x, y, color)
    circle(x + radius, y + radius, color)
  end

  def radius
    @options[:item_width] / 2
  end

end

