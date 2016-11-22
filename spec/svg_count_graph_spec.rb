require 'spec_helper'
require 'svg_count_graph'

RSpec.describe SvgCountGraph do

  describe '#render' do
    it 'outputs x when x: 1' do
      graph = SvgCountGraph.new({ x: 1 })
      expect(graph.render).to eq 'x'
    end
    it 'outputs xx when x: 2' do
      graph = SvgCountGraph.new({ x: 2 })
      expect(graph.render).to eq 'xx'
    end
    it "outputs xx\nx when x: 3, columns: 2" do
      graph = SvgCountGraph.new({ x: 3 }, { columns: 2 })
      expect(graph.render).to eq "xx\nx"
    end
    it "outputs xxx\nx when x: 4, columns: 3" do
      graph = SvgCountGraph.new({ x: 4 }, { columns: 3 })
      expect(graph.render).to eq "xxx\nx"
    end
    it "outputs xx\nxo\no when x: 3, o: 2, columns: 2" do
      graph = SvgCountGraph.new({ x: 3, o: 2 }, { columns: 2 })
      expect(graph.render).to eq "xx\nxo\no"
    end
  end

end
