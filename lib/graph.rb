class Graph
  attr_reader :data, :options, :prepared_data

  def initialize(data, options = {})
    validate_arguments(data, options)
    @data = data
    @options = default_options.merge options
    create_options_methods
    initialize_instance_variables
    @prepared_data = prepare_data
  end

  def validate_arguments(data, options)
    raise ArgumentError if data.empty?
    raise ArgumentError unless options.is_a? Hash
  end

  def default_options
    {
      type:   :svg,
      colors: ['#e41a1d', '#377eb9', '#4daf4b', '#984ea4', '#ff7f01', '#ffff34', '#a65629', '#f781c0', '#888888']
    }
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

  def initialize_instance_variables
  end

  def create_options_methods
    options.each do |key, value|
      define_singleton_method key, proc { value }
    end
  end
end
