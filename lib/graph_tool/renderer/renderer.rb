class GraphTool::Renderer
  attr_reader :graph

  def initialize(graph)
    @graph = graph
    if graph.type == :svg
      extend GraphTool::Renderer::SvgRenderer
    else
      extend GraphTool::Renderer::RvgRenderer
    end
    pre_draw
  end

  def post_draw
    filename = graph.options[:filename]
    if filename
      save filename
    else
      print
    end
  end

  def grid_line_style
    {
      stroke:       '#BBBBBB',
      stroke_width: 1
    }
  end

  def font_style
    {
      font_family: 'arial',
      font_size:   font_size
    }
  end

  def font_size
    16
  end
end
