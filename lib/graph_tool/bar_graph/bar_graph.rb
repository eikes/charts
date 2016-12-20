class GraphTool::BarGraph < GraphTool::Graph
  include GraphTool::Grid

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
      label_margin: 10
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
    group_labels.each_with_index do |group_label, i|
      x = outer_margin + (i + 0.5) * all_bars_width / group_count + i * group_margin
      y = outer_margin + inner_height + renderer.font_size
      renderer.text group_label, x, y, text_anchor: 'middle', class: 'group_label'
    end
  end

  def draw_labels
    return if options[:labels].nil? || labels.empty?
    label_row_length_sum = 0
    label_row = 1
    labels.each_with_index do |label, index|
      x = outer_margin + label_row_length_sum
      y = height - outer_margin - label_total_height + label_row * (label_height + label_margin)
      label_row_length_sum += label.length * 10 + label_height + label_margin
      if label_row_length_sum > inner_width
        label_row_length_sum = 0
        label_row += 1
      end
      renderer.rect x, y, label_height, label_height, fill: colors[index], stroke: colors[index]
      label_x = x + label_height + label_margin
      label_y = y + label_height - renderer.font_size / 3
      renderer.text label, label_x, label_y, text_anchor: 'start', class: 'label'
    end
  end

  def label_total_height
    return 0 if options[:labels].nil? || labels.empty?
    label_rows * (label_height + label_margin)
  end

  def label_rows
    return 0 if options[:labels].nil? || labels.empty?
    avg_character_width = 10
    ((labels.join.length * avg_character_width + 2 * labels.count * label_margin) / inner_width.to_f).ceil
  end

  def draw
    prepared_data.each_with_index do |set, set_nr|
      set.each_with_index do |data_value, bar_nr_in_set|
        Bar.new(self, data_value, set_nr, bar_nr_in_set).draw unless data_value.nil?
      end
    end
  end

  def inner_width
    width - 2 * outer_margin
  end

  def bar_outer_width
    all_bars_width.to_f / total_bar_count
  end

  def bar_inner_width
    bar_outer_width - 2 * bar_margin
  end

  def all_bars_width
    inner_width - sum_of_group_margins
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
end
