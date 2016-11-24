require_relative 'circle_count_graph'
require 'RMagick'

class BitmapCircleCountGraph < CircleCountGraph

  attr_reader :canvas, :image

  def pre_draw
    @image  = Magick::ImageList.new
    image.new_image(width, height)
    @canvas = Magick::Draw.new
  end

  def post_draw
    canvas.draw(image)
    image.to_blob { |attrs| attrs.format = 'PNG' }
  end

  def circle(cx, cy, color)
    canvas.fill color
    canvas.circle cx, cy, cx - radius, cy
  end

end

