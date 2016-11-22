require_relative 'count_graph'
class SymbolCountGraph < CountGraph

  def render
    prepared_data.map(&:join).join("\n")
  end
end
