module GraphTool::Grid

  class GridLine
    attr_accessor :graph, :value
    def initialize(graph, value)
      @graph = graph
      @value = value
    end

    def draw
      graph.renderer.line x1, y, x2, y, line_style
      graph.renderer.text label_text, label_x, label_y, font_style
    end

    def x1
      graph.outer_margin
    end

    def x2
      graph.width - graph.outer_margin
    end

    def y
      graph.outer_margin + graph.inner_height * (1 - graph.normalize(value))
    end

    def label_x
      x1 - 5
    end

    def label_y
      y + font_size / 3
    end

    def label_text
      if graph.spread_order_of_magnitude <= 0
        value.to_f
      else
        value
      end
    end

    def line_style
      {
        stroke:       '#BBBBBB',
        stroke_width: 1
      }
    end

    def font_style
      {
        font_family: 'arial',
        text_anchor: 'end',
        font_size:   font_size
      }
    end

    def font_size
      16
    end
  end

  def draw_grid
    lines.each { |l| l.draw }
  end

  def lines
    grid_line_values.map { |v| GridLine.new(self, v) }
  end

  def grid_line_values
    (0..number_of_grid_lines).map do |i|
      value = i.to_f * rounded_spread / number_of_grid_lines + min_value
      if spread_log10 < 1
        value.round(-spread_order_of_magnitude + 1)
      else
        value.round
      end
    end
  end

  def number_of_grid_lines
    (3..7).find { |line_count| spread_factor % line_count == 0 } || 4
  end

  def spread
    max_value - min_value
  end

  def spread_order_of_magnitude
    spread_log10.floor
  end

  def spread_log10
    Math.log10(spread)
  end

  def rounded_spread
    rs = spread_factor * 10 ** spread_order_of_magnitude
    spread_log10 % 1 == 0 ? rs / 10 : rs
  end

  def spread_factor
    f = (spread.to_f / 10 ** spread_order_of_magnitude).floor
    spread_log10 % 1 == 0 ? 10 * f : f
  end

end
