class Charts::BarChart::VerticalBar < Charts::BarChart::Bar
  def x
    (x_margin + x_offset).floor.to_i
  end

  def x_margin
    chart.outer_margin + chart.bar_margin + chart.group_margin * bar_nr_in_set
  end

  def x_offset
    chart.bar_outer_width * bar_number_in_chart
  end

  def y
    y_margin + y_offset
  end

  def y_margin
    chart.outer_margin
  end

  def y_offset
    chart.inner_height * [(1 - data_value), (1 - chart.base_line)].min
  end

  def width
    chart.bar_inner_width.floor.to_i
  end

  def height
    chart.inner_height * (data_value - chart.base_line).abs
  end
end
