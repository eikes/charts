require_relative 'graph'
require_relative 'image_renderer'

class BarGraph < Graph
  include ImageRenderer

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
      graph.inner_left + graph.bar_margin + graph.group_margin * bar_nr_in_set
    end

    def x_offset
      graph.bar_width * bar_number_in_graph
    end

    def y
      y_margin + y_offset
    end

    def y_margin
      graph.inner_top
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

  attr_reader :max, :min, :set_count, :bars_pers_set, :bar_count, :base_line

  def initialize(data, options = {})
    super(data, options)
    @set_count = data.count
    @bars_pers_set = data.map(&:count).max
    @bar_count = set_count * bars_pers_set
    @max = calc_max
    @min = calc_min
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
    renderer.rect inner_left, inner_top, inner_width, inner_height, fill: '#FFFFFF'
  end

  def draw
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_value, bar_nr_in_set|
        Bar.new(self, data_value, set_nr, bar_nr_in_set).draw
      end
    end
  end

  def inner_left
    options[:outer_margin]
  end

  def inner_top
    options[:outer_margin]
  end

  def width
    options[:width]
  end

  def inner_width
    width - 2 * options[:outer_margin]
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

  def height
    options[:height]
  end

  def inner_height
    height - 2 * options[:outer_margin]
  end

  def bar_margin
    options[:bar_margin]
  end

  def group_margin
    options[:group_margin]
  end

  def calc_max
    max = options[:max]
    unless max
      max = data.map(&:max).max
      max = 0 if max < 0 && options[:include_zero]
    end
    max
  end

  def calc_min
    min = options[:min]
    unless min
      min = data.map(&:min).min
      min = 0 if min > 0 && options[:include_zero]
    end
    min
  end

  def calc_base_line
    [[normalize(0), 0].max, 1].min # zero value normalized and clamp between 0 and 1
  end

  def normalize(value)
    (value - min.to_f) / (max - min)
  end

  def colors
    default_colors = ['#e41a1d', '#377eb9', '#4daf4b', '#984ea4', '#ff7f01', '#ffff34', '#a65629', '#f781c0', '#888888']
    options[:colors] || default_colors
  end
end
