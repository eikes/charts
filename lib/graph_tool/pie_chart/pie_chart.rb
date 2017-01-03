class GraphTool::PieChart < GraphTool::Graph
  include GraphTool::Legend

  attr_reader :sum,
              :sub_sums

  def validate_arguments(data, options)
    super(data, options)
    raise ArgumentError unless data.is_a? Array
    raise ArgumentError if options[:labels] && !options[:labels].empty? && options[:labels].count != data.count
    raise ArgumentError if options[:explode] && !options[:explode].empty? && options[:explode].count != data.count
  end

  def default_options
    super.merge(
      width:        600,
      height:       400,
      label_height: 20,
      label_margin: 10,
      explode:      nil,
      border_width: 2
    )
  end

  def prepare_data
    @sum = data.reduce 0, :+
    normalized_data = data.map { |value| value.to_f / sum }
    @sub_sums = (normalized_data.length + 1).times.map { |i| normalized_data.first(i).reduce 0.0, :+ }
    normalized_data
  end

  def pre_draw
    super
    draw_labels
  end

  def draw
    prepared_data.length.times do |i|
      start_deg = Math::PI * 2 * sub_sums[i]
      end_deg = Math::PI * 2 * sub_sums[i + 1]
      middle_deg = (start_deg + end_deg) / 2
      expl = explode ? explode[i] : 0
      middle_x = center_x + expl * Math.sin(middle_deg)
      middle_y = center_y - expl * Math.cos(middle_deg)
      start_x = middle_x + radius * Math.sin(start_deg)
      start_y = middle_y - radius * Math.cos(start_deg)
      end_x = middle_x + radius * Math.sin(end_deg)
      end_y = middle_y - radius * Math.cos(end_deg)
      more_than_half = prepared_data[i] > 0.5 ? 1 : 0
      path = "M#{middle_x} #{middle_y}
              L#{start_x} #{start_y}
              A#{radius} #{radius} 0 #{more_than_half} 1 #{end_x} #{end_y}
              L#{middle_x} #{middle_y}
              "
      renderer.path(path, fill: colors[i], stroke: background_color, stroke_width: border_width)
    end
  end

  def radius
    [inner_width, inner_height].min / 2
  end

  def center_x
    outer_margin + inner_width / 2
  end

  def center_y
    outer_margin + inner_height / 2
  end

  def inner_width
    width - 2 * outer_margin
  end

  def inner_height
    height - 2 * outer_margin - label_total_height
  end
end
