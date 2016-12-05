require 'rmagick'

class GraphTool::Renderer::MagickRenderer
  attr_reader :canvas, :image

  def initialize(width, height)
    @image = Magick::ImageList.new
    image.new_image(width, height)
    @canvas = Magick::Draw.new
  end

  def render
    canvas.draw(image)
    image.to_blob { |attrs| attrs.format = 'PNG' }
  end

  def save(filename)
    canvas.draw(image)
    image.write filename
  end

  def line(x1, y1, x2, y2, style)
    apply_canvas_style style
    canvas.line x1, y1, x2, y2
  end

  def circle(cx, cy, radius, style)
    apply_canvas_style style
    canvas.circle cx, cy, cx - radius, cy
  end

  def rect(x, y, width, height, style)
    apply_canvas_style style
    canvas.rectangle(x, y, x + width, y + height)
  end

  def apply_canvas_style(style)
    style.delete(:class)
    style.each do |key, value|
      canvas.send key, value
    end
  end
end
