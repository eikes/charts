require_relative 'count_graph'
class SvgCountGraph < CountGraph

  def render
    prepared_data.map(&:join).join("\n")
  end
end
