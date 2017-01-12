class Charts::Grid::GridLine
  attr_accessor :chart, :value

  def initialize(chart, value)
    @chart = chart
    @value = value
  end

  def draw
    chart.renderer.line x1, y1, x2, y2, chart.renderer.grid_line_style
    chart.renderer.text label_text, label_x, label_y, label_style
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
    if chart.spread_order_of_magnitude <= 0
      value.to_f
    else
      value
    end
  end
end
