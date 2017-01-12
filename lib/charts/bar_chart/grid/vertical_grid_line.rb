class Charts::Grid::VerticalGridLine < Charts::Grid::GridLine
  def y1
    chart.outer_margin
  end

  def y2
    chart.outer_margin + chart.inner_height
  end

  def x1
    chart.outer_margin + chart.inner_width * chart.normalize(value)
  end

  def x2
    x1
  end

  def label_y
    y2 + chart.renderer.font_size + 5
  end

  def label_x
    x1
  end

  def label_style
    {
      text_anchor: 'middle'
    }
  end
end
