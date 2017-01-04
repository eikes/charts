module Charts::Grid
  def draw_grid
    lines.each { |l| l.draw }
  end

  def lines
    grid_line_class = vertical? ? HorizontalGridLine : VerticalGridLine
    grid_line_values.map { |v| grid_line_class.new(self, v) }
  end

  def grid_line_values
    (0..number_of_grid_lines).map do |i|
      value = i.to_f * rounded_spread / number_of_grid_lines + min_value
      if spread_log10 < 1
        value.round(-spread_order_of_magnitude + 1)
      else
        value.round
      end
    end
  end

  def number_of_grid_lines
    (3..7).find { |line_count| spread_factor % line_count == 0 } || 4
  end

  def spread
    max_value - min_value
  end

  def spread_order_of_magnitude
    spread_log10.floor
  end

  def spread_log10
    Math.log10(spread)
  end

  def rounded_spread
    rs = spread_factor * 10 ** spread_order_of_magnitude
    spread_log10 % 1 == 0 ? rs / 10 : rs
  end

  def spread_factor
    f = (spread.to_f / 10 ** spread_order_of_magnitude).floor
    spread_log10 % 1 == 0 ? 10 * f : f
  end

end
