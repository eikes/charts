class Charts::Grid::GridLine
  attr_accessor :graph, :value

  def initialize(graph, value)
    @graph = graph
    @value = value
  end

  def draw
    graph.renderer.line x1, y1, x2, y2, graph.renderer.grid_line_style
    graph.renderer.text label_text, label_x, label_y, label_style
  end

  def x1
    raise NotImplementedError
  end

  def x2
    raise NotImplementedError
  end

  def y1
    raise NotImplementedError
  end

  def y2
    raise NotImplementedError
  end

  def label_x
    raise NotImplementedError
  end

  def label_y
    raise NotImplementedError
  end

  def label_text
    if graph.spread_order_of_magnitude <= 0
      value.to_f
    else
      value
    end
  end
end
