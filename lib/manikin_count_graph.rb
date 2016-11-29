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
    cx = x + @options[:item_width] / 2
    cy = y + @options[:item_height] / 4
    radius = @options[:item_height] / 8

    renderer.circle cx, cy, radius, fill: color
  end

  def body(x, y, color)
    left   = x + @options[:item_width] / 2
    right  = x + @options[:item_width] / 2
    top    = y + @options[:item_height] / 2
    bottom = y + @options[:item_height]
    style  = {
      stroke:         color,
      stroke_width:   @options[:item_width] / 4,
      stroke_linecap: 'round',
      class:          'body'
    }

    renderer.line left, top, right, bottom, style
  end

  def arms(x, y, color)
    left   = x + @options[:item_width] / 2
    right  = x + @options[:item_width] / 2
    top    = y + @options[:item_height] / 2 - @options[:item_height] * 0.12
    bottom = y + @options[:item_height] - @options[:item_height] * 0.15
    style  = {
      stroke:         color,
      stroke_width:   @options[:item_width] / 14,
      stroke_linecap: 'round'
    }

    style_left_arm = style.merge(class: 'left-arm', transform: "rotate(45 #{left} #{top})")
    renderer.line left, top, right, bottom, style_left_arm
    style_right_arm = style.merge(class: 'right-arm', transform: "rotate(-45 #{left} #{top})")
    renderer.line left, top, right, bottom, style_right_arm
  end
end
