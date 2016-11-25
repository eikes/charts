require_relative 'count_graph'
require_relative 'image_graph'

class CrossCountGraph < CountGraph
  include ImageGraph

  def draw_item(x, y, color)
    left = x + 4
    right = x + @options[:item_width] - 4
    top = y + 4
    bottom = y + @options[:item_height] - 4
    if is_svg?
      svg.line x1: left, y1: top, x2: right, y2: bottom, stroke: color, stroke_width: 6, stroke_linecap: 'round'
      svg.line x1: left, y1: bottom, x2: right, y2: top, stroke: color, stroke_width: 6, stroke_linecap: 'round'
    else
      canvas.stroke color
      canvas.stroke_width 6
      canvas.stroke_linecap 'round'
      canvas.line left, top, right, bottom
      canvas.line left, bottom, right, top
    end
  end
end
