class GraphTool::BarGraph < GraphTool::Graph
  include GraphTool::ImageRenderer

  class Bar
    attr_reader :graph, :data_value, :set_nr, :bar_nr_in_set

    def initialize(graph, data_value, set_nr, bar_nr_in_set)
      @graph = graph
      @data_value = data_value
      @set_nr = set_nr
      @bar_nr_in_set = bar_nr_in_set
    end

    def draw
      graph.renderer.rect x, y, width, height, fill: graph.colors[set_nr], class: 'bar'
    end

    def x
      (x_margin + x_offset).floor.to_i
    end

    def x_margin
      graph.outer_margin + graph.bar_margin + graph.group_margin * bar_nr_in_set
    end

    def x_offset
      graph.bar_width * bar_number_in_graph
    end

    def y
      y_margin + y_offset
    end

    def y_margin
      graph.outer_margin
    end

    def y_offset
      graph.inner_height * [(1 - data_value), (1 - graph.base_line)].min
    end

    def width
      graph.bar_inner_width.floor.to_i
    end

    def height
      graph.inner_height * (data_value - graph.base_line).abs
    end

    def bar_number_in_graph
      set_nr + bar_nr_in_set * graph.set_count
    end
  end

  attr_reader :max_value, :min_value, :set_count, :bars_pers_set, :bar_count, :base_line

  def initialize_instance_variables
    @set_count = data.count
    @bars_pers_set = data.map(&:count).max
    @bar_count = set_count * bars_pers_set
    @max_value = calc_max
    @min_value = calc_min
    @base_line = calc_base_line
  end

  def default_options
    super.merge(
      width:        600,
      height:       400,
      include_zero: true,
      outer_margin: 50,
      group_margin: 20,
      bar_margin:   1
    )
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
  end

  def prepare_data
    data.map do |set|
      set.map do |value|
        normalize(value)
      end
    end
  end

  def pre_draw
    super
    renderer.rect 0, 0, width, height, fill: '#EEEEEE'
    renderer.rect outer_margin, outer_margin, inner_width, inner_height, fill: '#FFFFFF'
  end

  def draw
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_value, bar_nr_in_set|
        Bar.new(self, data_value, set_nr, bar_nr_in_set).draw
      end
    end
  end

  def inner_width
    width - 2 * outer_margin
  end

  def bar_width
    all_bars_width.to_f / bar_count
  end

  def bar_inner_width
    bar_width - 2 * bar_margin
  end

  def all_bars_width
    inner_width - (bars_pers_set - 1) * group_margin
  end

  def inner_height
    height - 2 * outer_margin
  end

  def calc_max
    max = data.map(&:max).max
    max = 0 if max < 0 && include_zero
    options[:max] || max
  end

  def calc_min
    min = data.map(&:min).min
    min = 0 if min > 0 && include_zero
    options[:min] || min
  end

  def calc_base_line
    [[normalize(0), 0].max, 1].min # zero value normalized and clamp between 0 and 1
  end

  def normalize(value)
    (value.to_f - min_value) / (max_value - min_value)
  end
end
