require 'pry-byebug'
class GraphTool::CircleCountGraph < GraphTool::CountGraph
  include GraphTool::Renderer

  def draw_item(x, y, color)
    cx = x + item_width / 2
    cy = y + item_height / 2
    radius = item_width / 2

    renderer.circle cx, cy, radius, fill: color
  end

  def draw_label_text(x, y, labels)
    x = x + item_width * 2
    y = y + item_height / 2

    renderer.text(x, y, labels)
  end

end
