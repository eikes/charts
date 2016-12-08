module GraphTool::Grid
  def draw_grid
    spread = max_value - min_value
    number_of_lines = 5
    lines = []
    number_of_lines.times do |i|
      line_value = i * spread / (number_of_lines - 1)
      lines.push({
        line_value: line_value,
        line_position: inner_height * (1 - normalize(line_value))
      })
    end
    lines.each do |line|
      x1 = outer_margin
      x2 = width - outer_margin
      y = outer_margin + line[:line_position]
      renderer.line x1, y, x2, y, stroke: '#BBBBBB'
      font_size = 16
      renderer.text line[:line_value], x1 - 5, y + font_size / 3, font_family: 'arial', text_anchor: 'end', font_size: font_size
    end
  end
end
