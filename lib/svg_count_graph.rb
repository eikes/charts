require_relative 'image_count_graph'
require 'victor'

class SvgCountGraph < ImageCountGraph

  def pre_draw
    @svg = SVG.new width: width, height: height
  end

  def post_draw
    svg.render
  end

  def draw_item(column_count, row_count, color)
    cx = radius + 2 * column_count * radius
    cy = radius + 2 * row_count * radius
    svg.circle cx: cx, cy: cy, r: radius, fill: color
  end

end

