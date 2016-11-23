require_relative 'count_graph'
require 'victor'
class SvgCountGraph < CountGraph

  def render
    svg = SVG.new width: '100%', height: '100%'
    radius = 10
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |column, column_count|
        cx = radius + 2 * column_count * radius
        cy = radius + 2 * row_count * radius
        svg.circle cx: cx, cy: cy, r: radius, fill: column
      end
    end
    svg.render
  end
end
