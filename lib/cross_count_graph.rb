require_relative 'count_graph'
require_relative 'image_renderer'

class CrossCountGraph < CountGraph
  include ImageRenderer

  def draw_item(x, y, color)
    left   = x + 4
    right  = x + item_width - 4
    top    = y + 4
    bottom = y + item_height - 4

    style  = { stroke: color, stroke_width: 6, stroke_linecap: 'round' }

    renderer.line left, top, right, bottom, style
    renderer.line left, bottom, right, top, style
  end

  def draw_background_color(width, height, color)
    renderer.background_color width, height, fill: color, class: 'background_color'
  end
end
