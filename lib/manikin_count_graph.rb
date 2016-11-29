require_relative 'count_graph'
require_relative 'image_renderer'

class ManikinCountGraph < CountGraph
  include ImageRenderer

  def draw_item(x, y, color)
    head(x, y, color)
    body(x, y, color)
    arms(x, y, color)
  end

  def head(x, y, color)
    cx = x + item_width / 2
    cy = y + item_height / 4
    radius = item_height / 8

    renderer.circle cx, cy, radius, fill: color
  end

  def body(x, y, color)
    left   = x + item_width / 2
    right  = x + item_width / 2
    top    = y + item_height / 2
    bottom = y + item_height
    style  = {
      stroke:         color,
      stroke_width:   item_width / 4,
      stroke_linecap: 'round',
      class:          'body'
    }

    renderer.line left, top, right, bottom, style
  end

  def arms(x, y, color)
    left   = x + item_width / 2
    right  = x + item_width / 2
    top    = y + item_height / 2 - item_height * 0.12
    bottom = y + item_height - item_height * 0.15
    style  = {
      stroke:         color,
      stroke_width:   item_width / 14,
      stroke_linecap: 'round'
    }

    style_left_arm = style.merge(class: 'left-arm', transform: "rotate(45 #{left} #{top})")
    renderer.line left, top, right, bottom, style_left_arm
    style_right_arm = style.merge(class: 'right-arm', transform: "rotate(-45 #{left} #{top})")
    renderer.line left, top, right, bottom, style_right_arm
  end
end
