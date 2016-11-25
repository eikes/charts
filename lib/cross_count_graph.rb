require_relative 'image_count_graph'

class CrossCountGraph < ImageCountGraph

  def draw_item(column_count, row_count, color)
    x = column_count * @options[:item_width] + 4
    y = row_count * @options[:item_height] + 4
    width = @options[:item_width] - 8
    height = @options[:item_height] - 8
    cross(x, y, x + width, y + height, color)
  end

end

