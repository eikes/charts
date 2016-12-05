module GraphTool::Renderer
  attr_reader :renderer

  def pre_draw
    if type == :svg
      @renderer = SvgRenderer.new(width, height)
    else
      @renderer = MagickRenderer.new(width, height)
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
end
