require_relative 'count_graph'
require 'victor'

class SvgCountGraph < CountGraph

  attr_reader :svg

  def default_options
    super.merge(radius: 10)
  end

  def render
    pre_draw
    draw
    post_draw
  end

  def pre_draw
    @svg = SVG.new width: width, height: height
  end

  def draw
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |color, column_count|
        draw_item(column_count, row_count, color)
      end
    end
  end

  def post_draw
    svg.render
  end

  def draw_item(column_count, row_count, color)
    cx = radius + 2 * column_count * radius
    cy = radius + 2 * row_count * radius
    svg.circle cx: cx, cy: cy, r: radius, fill: color
  end

  def width
    prepared_data.first.count * 2 * radius
  end

  def height
    prepared_data.count * 2 * radius
  end

  def radius
    @options[:radius]
  end

end

