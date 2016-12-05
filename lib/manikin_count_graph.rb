require_relative 'count_graph'
require_relative 'image_renderer'

class ManikinCountGraph < CountGraph
  include ImageRenderer

  def draw_item(x, y, color)
    head x + width_percent(50), y, style(color)
    body x + width_percent(50), y, style(color)
    arms x + width_percent(50), y, style(color)
  end

  def head(x, y, style)
    cy = y + height_percent(20)
    radius = height_percent(10)

    renderer.circle x, cy, radius, style.merge(class: 'head')
  end

  def body(x, y, style)
    top    = y + height_percent(40)
    bottom = y + height_percent(95)

    renderer.line x, top, x, bottom, style.merge(stroke_width: width_percent(30), class: 'body')
  end

  def arms(x, y, style)
    top    = y + height_percent(40)
    bottom = y + height_percent(70)
    left_x = x - width_percent(25)
    right_x = x + width_percent(25)

    renderer.line left_x, top, left_x, bottom, style.merge(class: 'left-arm')
    renderer.line right_x, top, right_x, bottom, style.merge(class: 'right-arm')
  end

  def style(color)
    {
      fill:         color,
      stroke:       color,
      stroke_width: width_percent(10)
    }
  end

  def width_percent(multiplicator)
    multiplicator * item_width / 100
  end

  def height_percent(multiplicator)
    multiplicator * item_height / 100
  end

end
