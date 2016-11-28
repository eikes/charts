require_relative 'graph'
require_relative 'image_renderer'

class BarGraph < Graph
  include ImageRenderer

  attr_reader :max, :min, :set_count, :bars_pers_set, :bar_count, :base_line

  def default_options
    super.merge({
      width:  100,
      height: 100,
      include_zero: true,
      group_margin: 20,
      bar_margin: 2
    })
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
  end

  def prepare_data
    @set_count = data.count
    @bars_pers_set = data.map(&:count).max
    @bar_count = set_count * bars_pers_set

    @max = options[:max]
    if !@max
      @max = data.map(&:max).max
      if @max < 0 && options[:include_zero]
        @max = 0
      end
    end

    @min = options[:min]
    if !@min
      @min = data.map(&:min).min
      if @min > 0 && options[:include_zero]
        @min = 0
      end
    end

    @base_line = (-min.to_f) / (max - min) # zero value mapped
    puts @base_line
    @base_line = 0 if @base_line < 0
    @base_line = 1 if @base_line > 1

    prepared_data = data.map do |set|
      set.map do |item|
        #normalize data to a value between 0 and 1
        (item.to_f - min) / (max - min)
      end
    end
  end

  def draw
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_point, data_point_nr|
        bar_number = set_nr + data_point_nr * set_count
        draw_bar set_nr, data_point_nr, data_point
      end
    end
  end

  def draw_bar(set_nr, data_point_nr, data_point)
    # counting from left to right or top to bottom:
    bar_number = set_nr + data_point_nr * set_count

    width_without_group_margins = width.to_f - (set_count - 1) * options[:group_margin]

    w = (width_without_group_margins / bar_count).floor.to_i - 2 * options[:bar_margin]
    h = height * (data_point - base_line).abs
    x = (width_without_group_margins * bar_number / bar_count).floor.to_i
    x += options[:bar_margin] + options[:group_margin] * data_point_nr # Add margins
    y = height * ([(1 - data_point), (1 - base_line)].min)

    renderer.rect x, y, w, h, { fill: colors[set_nr] }
  end

  def width
    options[:width]
  end

  def height
    options[:height]
  end

  def colors
    options[:colors] || ['#e41a1d','#377eb9','#4daf4b','#984ea4','#ff7f01','#ffff34','#a65629','#f781c0','#888888']
  end
end
