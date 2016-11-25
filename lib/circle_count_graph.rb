require_relative 'count_graph'

class CircleCountGraph < CountGraph
  def draw_item(x, y, color)
    cx = x + @options[:item_width] / 2
    cy = y + @options[:item_height] / 2
    circle(cx, cy, color)
  end

  def radius
    @options[:item_width] / 2
  end
end
