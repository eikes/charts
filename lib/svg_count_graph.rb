require_relative 'count_graph'
require 'victor'
class SvgCountGraph < CountGraph
  def render
    width; height
    svg = SVG.new width: @width, height: @height
    radius = @options[:radius]
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |column, column_count|
        cx = radius + 2 * column_count * radius
        cy = radius + 2 * row_count * radius
        svg.circle cx: cx, cy: cy, r: radius, fill: column
      end
    end
    svg.render
  end

  def default_options
    super.merge(radius: 10)
  end

  def width
    column_count = prepared_data.first.count
    @width = column_count * 2 * @options[:radius]
  end

  def height
    row_count = prepared_data.count
    @height = row_count * 2 * @options[:radius]
  end
end
