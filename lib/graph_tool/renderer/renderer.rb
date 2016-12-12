module GraphTool::Renderer
  attr_reader :renderer

  def pre_draw
    if type == :svg
      @renderer = SvgRenderer.new(width, height)
    else
      @renderer = RvgRenderer.new(width, height)
    end
  end

  def post_draw
    filename = options[:filename]
    if filename
      renderer.save filename
    else
      renderer.render
    end
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
