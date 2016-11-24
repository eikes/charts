require_relative 'count_graph'
class ImageCountGraph < CountGraph

  def default_options
    super.merge(item_width: 20)
    super.merge(item_height: 20)
  end

  def render
    pre_draw
    draw
    post_draw
  end

  def pre_draw
    raise NoMethodError
  end

  def draw
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |color, column_count|
        draw_item(column_count, row_count, color)
      end
    end
  end

  def post_draw
    raise NoMethodError
  end

  def draw_item
    raise NoMethodError
  end

  def width
    prepared_data.first.count * @options[:item_width]
  end

  def height
    prepared_data.first.count * @options[:item_height]
  end

end
