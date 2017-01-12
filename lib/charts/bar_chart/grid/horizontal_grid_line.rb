class Charts::Grid::HorizontalGridLine < Charts::Grid::GridLine
  def x1
    chart.outer_margin
  end

  def x2
    chart.width - chart.outer_margin
  end

  def y1
    chart.outer_margin + chart.inner_height * (1 - chart.normalize(value))
  end

  def y2
    y1
  end

  def label_x
    x1 - 5
  end

  def label_y
    y1 + chart.renderer.font_size / 3
  end

  def label_style
    { text_anchor: 'end' }
  end
end
