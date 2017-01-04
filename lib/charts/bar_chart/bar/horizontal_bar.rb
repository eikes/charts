class Charts::BarChart::HorizontalBar < Charts::BarChart::Bar
  def x
    x_margin + x_offset
  end

  def x_margin
    graph.outer_margin
  end

  def x_offset
    graph.inner_width * [data_value, graph.base_line].min
  end

  def y
    (y_margin + y_offset).floor.to_i
  end

  def y_margin
    graph.outer_margin + graph.bar_margin + graph.group_margin * bar_nr_in_set
  end

  def y_offset
    graph.bar_outer_width * bar_number_in_graph
  end

  def width
    graph.inner_width * (data_value - graph.base_line).abs
  end

  def height
    graph.bar_inner_width.floor.to_i
  end
end
