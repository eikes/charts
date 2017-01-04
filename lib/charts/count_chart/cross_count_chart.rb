class Charts::CrossCountChart < Charts::CountChart
  def draw_item(x, y, color)
    left   = x + 4
    right  = x + item_width - 4
    top    = y + 4
    bottom = y + item_height - 4

    style  = { stroke: color, stroke_width: 6, stroke_linecap: 'round' }

    renderer.line left, top, right, bottom, style
    renderer.line left, bottom, right, top, style
  end
end
