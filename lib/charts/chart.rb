class Charts::Chart
  attr_reader :data, :options, :prepared_data, :renderer

  def initialize(data, opts = {})
    validate_arguments(data, opts)
    @data = data
    @options = default_options.merge opts
    create_options_methods
    initialize_instance_variables
    @prepared_data = prepare_data
  end

  def validate_arguments(data, options)
    raise ArgumentError.new('Data missing') if data.empty?
    raise ArgumentError.new('Data not an array') unless data.is_a? Array
    raise ArgumentError.new('Options missing') unless options.is_a? Hash
    if options[:outer_margin] and !options[:outer_margin].is_a?(Numeric)
      raise ArgumentError.new('outer_margin not a number')
    end
    validate_array_and_count(data, options, :colors)
    validate_array_and_count(data, options, :labels)
  end

  def validate_array_and_count(data, options, key)
    if options[key]
      unless options[key].is_a? Array
        raise ArgumentError.new("#{ key } not an array")
      end
      if options[key].any? and data.count > options[key].count
        raise ArgumentError.new("not enough #{ key }")
      end
    end
  end

  def default_options
    {
      title:            nil,
      type:             :svg,
      outer_margin:     30,
      background_color: 'white',
      labels:           [],
      colors:           [
        '#e41a1d',
        '#377eb9',
        '#4daf4b',
        '#984ea4',
        '#ff7f01',
        '#ffff34',
        '#a65629',
        '#f781c0',
        '#888888'
      ]
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
    @renderer = Charts::Renderer.new(self)
    draw_background
    draw_title
  end

  def draw
    raise NotImplementedError
  end

  def post_draw
    renderer.post_draw
  end

  def draw_background
    renderer.rect 0, 0, width, height, fill: background_color, class: 'background_color'
  end

  def draw_title
    return unless options[:title]
    x = width / 2
    y = outer_margin / 2 + 2 * renderer.font_size / 5
    renderer.text options[:title], x, y, text_anchor: 'middle', class: 'title'
  end

  def initialize_instance_variables
  end

  def create_options_methods
    options.each do |key, value|
      define_singleton_method key, proc { value }
    end
  end
end
