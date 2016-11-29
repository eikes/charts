require_relative 'graph'

class CountGraph < Graph
  def default_options
    super.merge({ columns: 10, item_width: 20, item_height: 20 })
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Hash
    raise ArgumentError unless data.values.all? { |x| Integer(x) }
  end

  def prepare_data
    prepared_data = []
    data.each do |key, value|
      value.to_i.times { prepared_data << key.to_s }
    end
    prepared_data.each_slice(options[:columns]).to_a
  end

  def draw
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |color, column_count|
        x = column_count * item_width
        y = row_count * item_height
        draw_item(x, y, color)
      end
    end
  end

  def draw_item(_x, _y, _color)
    raise NotImplementedError
  end

  def width
    prepared_data.first.count * item_width
  end

  def height
    prepared_data.count * item_height
  end

  def item_width
    @options[:item_width]
  end

  def item_height
    @options[:item_height]
  end
end
