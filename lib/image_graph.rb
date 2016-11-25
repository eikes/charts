require 'rmagick'
require 'victor'

module ImageGraph
  attr_reader :graph

  def pre_draw
    @graph = options[:type] == :svg ? SvgGraph.new(width, height) : BitmapGraph.new(width, height)
  end

  def post_draw
    filename = options[:filename]
    if filename
      graph.save filename
    else
      graph.render
    end
  end

  class SvgGraph
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

    def line(x1, y1, x2, y2, style)
      svg.line style.merge(x1: x1, y1: y1, x2: x2, y2: y2)
    end

    def circle(cx, cy, radius, style)
      svg.circle style.merge(cx: cx, cy: cy, r: radius)
    end
  end

  class BitmapGraph
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

    def apply_canvas_style(style)
      style.each do |key, value|
        canvas.send key, value
      end
    end
  end
end
