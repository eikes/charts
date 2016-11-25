require_relative 'count_graph'
require_relative 'image_graph'

class CircleCountGraph < CountGraph
  include ImageGraph

  def draw_item(x, y, color)
    cx = x + @options[:item_width] / 2
    cy = y + @options[:item_height] / 2
    radius = @options[:item_width] / 2
    if is_svg?
      svg.circle cx: cx, cy: cy, r: radius, fill: color
    else
      canvas.fill color
      canvas.circle cx, cy, x, cy
    end
  end
end
