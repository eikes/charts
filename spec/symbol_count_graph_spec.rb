require 'symbol_count_graph'

RSpec.describe SymbolCountGraph do

  describe '#render' do
    it 'outputs x when x: 1' do
      graph = SymbolCountGraph.new x: 1
      expect(graph.render).to eq 'x'
    end
    it 'outputs xx when x: 2' do
      graph = SymbolCountGraph.new x: 2
      expect(graph.render).to eq 'xx'
    end
  end

end