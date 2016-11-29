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
    center_x = center_(x)
    cy = y + @options[:item_height] / 4
    radius = @options[:item_height] / 8

    renderer.circle center_x, cy, radius, fill: color
  end

  def body(x, y, color)
    center_x = center_(x)
    top    = y + @options[:item_height] / 2
    bottom = y + @options[:item_height]
    style  = {
      stroke:         color,
      stroke_width:   @options[:item_width] / 4,
      stroke_linecap: 'round',
      class:          'body'
    }

    renderer.line center_x, top, center_x, bottom, style
  end

  def arms(x, y, color)
    center_x = center_(x)
    top    = y + @options[:item_height] / 2 - @options[:item_height] * 0.12
    bottom = y + @options[:item_height] - @options[:item_height] * 0.15
    style  = {
      stroke:         color,
      stroke_width:   @options[:item_width] / 14,
      stroke_linecap: 'round'
    }

    style_left_arm = style.merge(class: 'left-arm', transform: "rotate(45 #{center_x} #{top})")
    renderer.line center_x, top, center_x, bottom, style_left_arm
    style_right_arm = style.merge(class: 'right-arm', transform: "rotate(-45 #{center_x} #{top})")
    renderer.line center_x, top, center_x, bottom, style_right_arm
  end

  def center_(x)
    x + @options[:item_width] / 2
  end
end
