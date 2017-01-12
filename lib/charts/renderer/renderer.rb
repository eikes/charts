class Charts::Renderer
  attr_reader :chart

  def initialize(chart)
    @chart = chart
    if chart.type == :svg
      extend Charts::Renderer::SvgRenderer
    else
      extend Charts::Renderer::RvgRenderer
    end
    pre_draw
  end

  def post_draw
    filename = chart.options[:filename]
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
