require_relative 'count_graph'
require_relative 'image_renderer'

class CircleCountGraph < CountGraph
  include ImageRenderer

  def draw_item(x, y, color)
    cx = x + @options[:item_width] / 2
    cy = y + @options[:item_height] / 2
    radius = @options[:item_width] / 2

    renderer.circle cx, cy, radius, { fill: color }
  end
end
