require_relative 'count_graph'
require_relative 'image_graph'

class CrossCountGraph < CountGraph
  include ImageGraph

  def draw_item(x, y, color)
    left   = x + 4
    right  = x + @options[:item_width] - 4
    top    = y + 4
    bottom = y + @options[:item_height] - 4

    style  = { stroke: color, stroke_width: 6, stroke_linecap: 'round' }

    graph.line left, top, right, bottom, style
    graph.line left, bottom, right, top, style
  end
end
