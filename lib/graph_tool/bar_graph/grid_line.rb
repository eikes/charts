class GraphTool::Grid::GridLine
  attr_accessor :graph, :value

  def initialize(graph, value)
    @graph = graph
    @value = value
  end

  def draw
    graph.renderer.line x1, y, x2, y, line_style
    graph.renderer.text label_text, label_x, label_y, graph.font_style.merge(text_anchor: 'end')
  end

  def x1
    graph.outer_margin
  end

  def x2
    graph.width - graph.outer_margin
  end

  def y
    graph.outer_margin + graph.inner_height * (1 - graph.normalize(value))
  end

  def label_x
    x1 - 5
  end

  def label_y
    y + graph.font_size / 3
  end

  def label_text
    if graph.spread_order_of_magnitude <= 0
      value.to_f
    else
      value
    end
  end

  def line_style
    {
      stroke:       '#BBBBBB',
      stroke_width: 1
    }
  end
end
