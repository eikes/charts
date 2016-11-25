require 'rmagick'
require 'victor'

module ImageGraph
  attr_reader :canvas, :image, :svg

  def is_svg?
    options[:type] == :svg
  end

  def pre_draw
    if is_svg?
      @svg = SVG.new width: width, height: height
    else
      @image = Magick::ImageList.new
      image.new_image(width, height)
      @canvas = Magick::Draw.new
    end
  end

  def post_draw
    filename = options[:filename]
    if is_svg?
      if filename
        svg.save filename
      else
        svg.render
      end
    else
      canvas.draw(image)
      if filename
        image.write filename
      else
        image.to_blob { |attrs| attrs.format = 'PNG' }
      end
    end
  end

  def line(x1, y1, x2, y2, style)
    if is_svg?
      svg.line style.merge({ x1: x1, y1: y1, x2: x2, y2: y2 })
    else
      set_canvas_style style
      canvas.line x1, y1, x2, y2
    end
  end

  def circle(cx, cy, radius, style)
    if is_svg?
      svg.circle style.merge({ cx: cx, cy: cy, r: radius })
    else
      set_canvas_style style
      canvas.circle cx, cy, cx - radius, cy
    end
  end

  def set_canvas_style(style)
    style.each do |key, value|
      canvas.send key, value
    end
  end
end
