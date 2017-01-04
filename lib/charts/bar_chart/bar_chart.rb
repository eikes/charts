class Charts::BarChart < Charts::Chart
  include Charts::Grid
  include Charts::Legend

  attr_reader :max_value,
              :min_value,
              :set_count,
              :group_count,
              :total_bar_count,
              :base_line

  def initialize_instance_variables
    @set_count = data.count
    @group_count = data.map(&:count).max
    @total_bar_count = set_count * group_count
    @max_value = calc_max
    @min_value = calc_min
    @base_line = calc_base_line
  end

  def default_options
    super.merge(
      width:        600,
      height:       400,
      include_zero: true,
      group_margin: 20,
      bar_margin:   3,
      label_height: 20,
      label_margin: 10,
      direction:    :vertical
    )
  end

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
  end

  def prepare_data
    data.map do |set|
      set.map do |value|
        value.nil? ? nil : normalize(value)
      end
    end
  end

  def pre_draw
    super
    draw_grid
    draw_group_labels
    draw_labels
  end

  def draw_group_labels
    return if options[:group_labels].nil? || group_labels.empty?
    raise ArgumentError if group_labels.count != group_count
    group_label_style = {
      text_anchor:  'middle',
      writing_mode: (vertical? ? 'lr' : 'tb'),
      class:        'group_label'
    }
    group_labels.each_with_index do |group_label, i|
      if vertical?
        x = outer_margin + (i + 0.5) * all_bars_width / group_count + i * group_margin
        y = outer_margin + inner_height + renderer.font_size
      else
        x = outer_margin - renderer.font_size
        y = outer_margin + (i + 0.5) * all_bars_width / group_count + i * group_margin
      end
      renderer.text group_label, x, y, group_label_style
    end
  end

  def draw
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_value, bar_nr_in_set|
        bar_class = vertical? ? VerticalBar : HorizontalBar
        bar_class.new(self, data_value, set_nr, bar_nr_in_set).draw unless data_value.nil?
      end
    end
  end

  def inner_width
    width - 2 * outer_margin
  end

  def bar_inner_width
    bar_outer_width - 2 * bar_margin
  end

  def bar_outer_width
    all_bars_width.to_f / total_bar_count
  end

  def all_bars_width
    (vertical? ? inner_width : inner_height) - sum_of_group_margins
  end

  def sum_of_group_margins
    (group_count - 1) * group_margin
  end

  def inner_height
    height - 2 * outer_margin - label_total_height
  end

  def calc_max
    max = data.map{ |d| d.reject(&:nil?).max }.max
    max = 0 if max < 0 && include_zero
    options[:max] || max
  end

  def calc_min
    min = data.map{ |d| d.reject(&:nil?).min }.min
    min = 0 if min > 0 && include_zero
    options[:min] || min
  end

  def calc_base_line
    [[normalize(0), 0].max, 1].min # zero value normalized and clamped between 0 and 1
  end

  def normalize(value)
    (value.to_f - min_value) / (max_value - min_value)
  end

  def vertical?
    direction == :vertical
  end
end
