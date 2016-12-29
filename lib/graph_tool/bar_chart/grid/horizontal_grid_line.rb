class GraphTool::Grid::HorizontalGridLine < GraphTool::Grid::GridLine
  def x1
    graph.outer_margin
  end

  def x2
    graph.width - graph.outer_margin
  end

  def y1
    graph.outer_margin + graph.inner_height * (1 - graph.normalize(value))
  end

  def y2
    y1
  end

  def label_x
    x1 - 5
  end

  def label_y
    y1 + graph.renderer.font_size / 3
  end

  def label_style
    { text_anchor: 'end' }
  end
end
