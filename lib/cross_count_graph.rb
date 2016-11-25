require_relative 'image_count_graph'

class CrossCountGraph < ImageCountGraph

  def draw_item(x, y, color)
    width = @options[:item_width] - 8
    height = @options[:item_height] - 8
    cross(x + 4, y + 4, x + width, y + height, color)
  end

end

