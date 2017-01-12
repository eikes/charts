class Charts::BarChart::HorizontalBar < Charts::BarChart::Bar
  def x
    x_margin + x_offset
  end

  def x_margin
    chart.outer_margin
  end

  def x_offset
    chart.inner_width * [data_value, chart.base_line].min
  end

  def y
    (y_margin + y_offset).floor.to_i
  end

  def y_margin
    chart.outer_margin + chart.bar_margin + chart.group_margin * bar_nr_in_set
  end

  def y_offset
    chart.bar_outer_width * bar_number_in_chart
  end

  def width
    chart.inner_width * (data_value - chart.base_line).abs
  end

  def height
    chart.bar_inner_width.floor.to_i
  end
end
