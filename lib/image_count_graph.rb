require_relative 'count_graph'

class ImageCountGraph < CountGraph

  attr_reader :svg

  def default_options
    super.merge(radius: 10)
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

  def draw_item(column_count, row_count, color)
    raise NoMethodError
  end

  def width
    prepared_data.first.count * 2 * radius
  end

  def height
    prepared_data.count * 2 * radius
  end

  def radius
    @options[:radius]
  end

end

