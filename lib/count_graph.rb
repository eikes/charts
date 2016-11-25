class CountGraph

  attr_reader :data, :options, :prepared_data

  def initialize(data, options = {})
    validate_arguments(data, options)
    @data = data
    @options = default_options.merge options
    @prepared_data = prepare_data
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless data.is_a? Hash
    raise ArgumentError unless options.is_a? Hash
    raise ArgumentError unless data.values.all? { |x| Integer(x) }
  end

  def default_options
    { columns: 10, item_width: 20, item_height: 20 }
  end

  def prepare_data
    prepared_data = []
    data.each do |key, value|
      value.to_i.times { prepared_data << key.to_s }
    end
    prepared_data.each_slice(options[:columns]).to_a
  end

  def render
    pre_draw
    draw
    post_draw
  end

  def pre_draw
    raise NotImplementedError
  end

  def draw
    prepared_data.each_with_index do |row, row_count|
      row.each_with_index do |color, column_count|
        draw_item(column_count, row_count, color)
      end
    end
  end

  def draw_item
    raise NotImplementedError
  end

  def post_draw
    raise NotImplementedError
  end

  def width
    prepared_data.first.count * @options[:item_width]
  end

  def height
    prepared_data.count * @options[:item_height]
  end

end
