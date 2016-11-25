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
    if is_svg?
      if options[:filename]
        svg.save options[:filename]
      else
        svg.render
      end
    else
      canvas.draw(image)
      if options[:filename]
        image.write options[:filename]
      else
        image.to_blob { |attrs| attrs.format = 'PNG' }
      end
    end
  end
end
