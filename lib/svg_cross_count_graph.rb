require_relative 'cross_count_graph'
require 'victor'

class SvgCrossCountGraph < CrossCountGraph

  attr_reader :svg

  def pre_draw
    @svg = SVG.new width: width, height: height
  end

  def post_draw
    svg.render
  end

  def cross(left, top, right, bottom, color)
    svg.line(x1: left, y1: top, x2: right, y2: bottom, stroke: color, stroke_width: 6, stroke_linecap: 'round')
    svg.line(x1: left, y1: bottom, x2: right, y2: top, stroke: color, stroke_width: 6, stroke_linecap: 'round')
  end

  def save
    pre_draw
    draw
    svg.save options[:filename]
  end

end

