require_relative 'count_graph'

class SymbolCountGraph < CountGraph
  def render
    render = prepared_data.map { |row| row.map(&:chr).join }.join("\n")
    if options[:filename]
      File.open(options[:filename], 'w') { |file| file.write(render) }
    else
      render
    end
  end
end
