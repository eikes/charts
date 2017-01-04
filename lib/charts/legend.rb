module Charts::Legend
  def draw_labels
    return if options[:labels].nil? || labels.empty?
    label_row_length_sum = 0
    label_row = 1
    labels.each_with_index do |label, index|
      x = outer_margin + label_row_length_sum
      y = height - outer_margin - label_total_height + label_row * (label_height + label_margin)
      label_row_length_sum += label.length * 10 + label_height + 2 * label_margin
      if label_row_length_sum > inner_width
        label_row_length_sum = 0
        label_row += 1
      end
      renderer.rect x, y, label_height, label_height, fill: colors[index], stroke: colors[index]
      label_x = x + label_height + label_margin
      label_y = y + label_height - renderer.font_size / 3
      renderer.text label, label_x, label_y, text_anchor: 'start', class: 'label'
    end
  end

  def label_total_height
    return 0 if options[:labels].nil? || labels.empty?
    label_rows * (label_height + label_margin)
  end

  def label_rows
    return 0 if options[:labels].nil? || labels.empty?
    avg_character_width = 10
    ((labels.join.length * avg_character_width + 2 * labels.count * label_margin) / inner_width.to_f).ceil
  end
end
