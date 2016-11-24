require_relative 'circle_count_graph'
require 'victor'

class SvgCircleCountGraph < CircleCountGraph

  attr_reader :svg

  def pre_draw
    @svg = SVG.new width: width, height: height
  end

  def post_draw
    svg.render
  end

  def circle(cx, cy, color)
    svg.circle cx: cx, cy: cy, r: radius, fill: color
  end

  def save
    pre_draw
    draw
    svg.save options[:filename]
  end

end

