require_relative 'count_graph'
require_relative 'image_renderer'

class CircleCountGraph < CountGraph
  include ImageRenderer

  def draw_item(x, y, color)
    cx = x + item_width / 2
    cy = y + item_height / 2
    radius = item_width / 2

    renderer.circle cx, cy, radius, { fill: color }
  end
end
