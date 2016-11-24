require_relative 'count_graph'

class SymbolCountGraph < CountGraph

  def render
    prepared_data.map{ |row| row.map(&:chr).join }.join("\n")
  end

  def save
    File.open(options[:filename], 'w') { |file| file.write(render) }
  end

end
