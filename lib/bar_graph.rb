require_relative 'graph'
require_relative 'image_renderer'

class BarGraph < Graph
  include ImageRenderer

  attr_reader :max, :min, :data_set_count, :bars_pers_set, :bar_count, :base_line

  def default_options
    super.merge({
      width:  100,
      height: 100,
      include_zero: true
    })
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
  end

  def prepare_data
    @data_set_count = data.count
    @bars_pers_set = data.map(&:count).max
    @bar_count = data_set_count * bars_pers_set

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
    prepared_data.each_with_index do |set, set_count|
      set.each_with_index do |data_point, data_point_count|
        bar_number = set_count + data_point_count * data_set_count
        draw_bar set_count, data_point_count, data_point
      end
    end
  end

  def draw_bar(set_count, data_point_count, data_point)
    # counting from left to right or top to bottom:
    bar_number = set_count + data_point_count * data_set_count

    w = (width.to_f / bar_count).floor.to_i
    h = height * (data_point - base_line).abs
    x = width.to_f * bar_number / bar_count
    y = height * ([(1 - data_point), (1 - base_line)].min)

    renderer.rect x, y, w, h, { fill: colors[set_count] }
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
