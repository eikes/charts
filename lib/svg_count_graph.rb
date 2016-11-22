require_relative 'count_graph'
require 'victor'
class SvgCountGraph < CountGraph

  def render
    svg = SVG.new width: '100%', height: '100%'
    svg.circle cx: 10, cy: 10, r: 10, fill: '#FF0000'
    svg.render
  end
end
