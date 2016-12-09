module GraphTool::Grid

  class GridLine
    attr_accessor :graph, :value
    def initialize(graph, value)
      @graph = graph
      @value = value
    end

    def draw
      graph.renderer.line x1, y, x2, y, line_style
      graph.renderer.text value, label_x, label_y, font_style
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
    grid_line_values.map { |v| GridLine.new(self, v).draw }
  end

  def grid_line_values
    (0..(number_of_lines-1)).map do |i|
      (i * spread / (number_of_lines - 1)).round
    end
  end

  def number_of_lines
    5
  end

  def spread
    max_value - min_value
  end
end
