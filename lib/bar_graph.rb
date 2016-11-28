require_relative 'graph'
require_relative 'image_renderer'

class BarGraph < Graph
  include ImageRenderer

  attr_reader :max, :min, :set_count, :bars_pers_set, :bar_count, :base_line

  def default_options
    super.merge(width:  600,
                height: 400,
                include_zero: true,
                outer_margin: 50,
                group_margin: 20,
                bar_margin: 1)
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
  end

  def prepare_data
    @set_count = data.count
    @bars_pers_set = data.map(&:count).max
    @bar_count = set_count * bars_pers_set
    @max = calc_max
    @min = calc_min
    @base_line = calc_base_line

    data.map do |set|
      set.map do |item|
        # normalize data to a value between 0 and 1
        (item.to_f - min) / (max - min)
      end
    end
  end

  def draw
    draw_background
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_point, data_point_nr|
        draw_bar set_nr, data_point_nr, data_point
      end
    end
  end

  def draw_bar(set_nr, data_point_nr, data_point)
    # counting from left to right or top to bottom:
    bar_number = set_nr + data_point_nr * set_count

    all_bars_width = inner_width.to_f - (bars_pers_set - 1) * group_margin

    w = (all_bars_width / bar_count).floor.to_i - 2 * bar_margin
    h = inner_height * (data_point - base_line).abs

    x = inner_left + bar_margin + (all_bars_width * bar_number / bar_count).floor.to_i + group_margin * data_point_nr
    y = inner_top + inner_height * [(1 - data_point), (1 - base_line)].min

    renderer.rect x, y, w, h, fill: colors[set_nr], class: 'bar'
  end

  def draw_background
    renderer.rect 0, 0, width, height, fill: '#EEEEEE'
    renderer.rect inner_left, inner_top, inner_width, inner_height, fill: '#FFFFFF'
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
      max = 0 if max.negative? && options[:include_zero]
    end
    max
  end

  def calc_min
    min = options[:min]
    unless min
      min = data.map(&:min).min
      min = 0 if min.positive? && options[:include_zero]
    end
    max
  end

  def calc_base_line
    base_line = (-min.to_f) / (max - min) # zero value mapped
    base_line = 0 if base_line.negative?
    base_line = 1 if base_line > 1
    base_line
  end

  def colors
    default_colors = ['#e41a1d', '#377eb9', '#4daf4b', '#984ea4', '#ff7f01', '#ffff34', '#a65629', '#f781c0', '#888888']
    options[:colors] || default_colors
  end
end
