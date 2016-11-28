class Graph
  attr_reader :data, :options, :prepared_data

  def initialize(data, options = {})
    validate_arguments(data, options)
    @data = data
    @options = default_options.merge options
    @prepared_data = prepare_data
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless options.is_a? Hash
  end

  def default_options
    { type: :svg }
  end

  def prepare_data
    data
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
    raise NotImplementedError
  end

  def post_draw
    raise NotImplementedError
  end
end
