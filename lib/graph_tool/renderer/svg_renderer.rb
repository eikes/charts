require 'victor'

class GraphTool::Renderer::SvgRenderer
  attr_reader :svg

  def initialize(width, height)
    @svg = SVG.new width: width, height: height
  end

  def render
    svg.render
  end

  def save(filename)
    svg.save filename
  end

  def line(x1, y1, x2, y2, style = {})
    svg.line style.merge(x1: x1, y1: y1, x2: x2, y2: y2)
  end

  def circle(cx, cy, radius, style = {})
    svg.circle style.merge(cx: cx, cy: cy, r: radius)
  end

  def rect(x, y, width, height, style = {})
    svg.rect style.merge(x: x, y: y, width: width, height: height)
  end

  def text(text, x, y, style = {})
    svg.text text, style.merge(x: x, y: y)
  end
end
