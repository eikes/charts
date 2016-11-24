require_relative 'image_count_graph'

class CircleCountGraph < ImageCountGraph

  def draw_item(column_count, row_count, color)
    cx = radius + 2 * column_count * radius
    cy = radius + 2 * row_count * radius
    circle(cx, cy, color)
  end

  def radius
    @options[:item_width] / 2
  end

end

