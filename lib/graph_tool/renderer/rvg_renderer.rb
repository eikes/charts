require 'rvg/rvg'

class GraphTool::Renderer::RvgRenderer
  attr_reader :rvg, :image_width, :image_height

  def initialize(image_width, image_height)
    @image_width = image_width
    @image_height = image_height

    @rvg = Magick::RVG.new(image_width, image_height) do |canvas|
      canvas.background_fill = 'white'
    end
  end

  def render
    rvg.draw.to_blob { |attrs| attrs.format = 'PNG' }
  end

  def save(filename)
    rvg.draw.write filename
  end

  def line(x1, y1, x2, y2, style)
    canvas(style) { |c| c.line x1, y1, x2, y2 }
  end

  def circle(cx, cy, radius, style)
    canvas(style) { |c| c.circle radius, cx, cy }
  end

  def rect(x, y, width, height, style)
    canvas(style) { |c| c.rect width, height, x, y }
  end

  def text(text, x, y, style = {})
    canvas(style) { |c| c.text x, y, text }
  end

  def canvas(style)
    style.delete(:class)
    rvg.rvg(image_width, image_height) do |canvas|
      yield(canvas).styles(style)
    end
  end
end
