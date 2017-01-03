class GraphTool::Grid::VerticalGridLine < GraphTool::Grid::GridLine
  def y1
    graph.outer_margin
  end

  def y2
    graph.outer_margin + graph.inner_height
  end

  def x1
    graph.outer_margin + graph.inner_width * graph.normalize(value)
  end

  def x2
    x1
  end

  def label_y
    y2 + graph.renderer.font_size + 5
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
