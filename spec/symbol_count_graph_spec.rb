require 'spec_helper'
require 'symbol_count_graph'

RSpec.describe SymbolCountGraph do

  describe '#initialize' do
    it 'raises an error when no data is provided' do
      expect{ SymbolCountGraph.new }.to raise_error(ArgumentError)
    end
    it 'calls the validate_arguments method' do
      expect_any_instance_of(SymbolCountGraph).to receive(:validate_arguments)
      SymbolCountGraph.new({})
    end
    it 'raises an error when the data hash is empty' do
      expect{ SymbolCountGraph.new({}) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the data is not a hash' do
      expect{ SymbolCountGraph.new('x') }.to raise_error(ArgumentError)
    end
    it 'raises an error when the options are not a hash' do
      expect{ SymbolCountGraph.new({ x: 2 }, 'x') }.to raise_error(ArgumentError)
    end

    it 'stores the data in an instance attribute' do
      graph = SymbolCountGraph.new({ x: 2 })
      expect(graph.data).to eq({ x: 2 })
    end
    it 'stores the options in an instance attribute' do
      graph = SymbolCountGraph.new({ x: 2 }, { columns: 2 })
      expect(graph.options).to eq({ columns: 2 })
    end
    it 'provides default options' do
      graph = SymbolCountGraph.new({ x: 2 })
      expect(graph.options[:columns]).to eq(10)
    end
  end

  describe '#render' do
    it 'outputs x when x: 1' do
      graph = SymbolCountGraph.new({ x: 1 })
      expect(graph.render).to eq 'x'
    end
    it 'outputs xx when x: 2' do
      graph = SymbolCountGraph.new({ x: 2 })
      expect(graph.render).to eq 'xx'
    end
    it "outputs xx\nx when x: 3, columns: 2" do
      graph = SymbolCountGraph.new({ x: 3 }, { columns: 2 })
      expect(graph.render).to eq "xx\nx"
    end
    it "outputs xxx\nx when x: 4, columns: 3" do
      graph = SymbolCountGraph.new({ x: 4 }, { columns: 3 })
      expect(graph.render).to eq "xxx\nx"
    end
    it "outputs xx\nxo\no when x: 3, o: 2, columns: 2" do
      graph = SymbolCountGraph.new({ x: 3, o: 2 }, { columns: 2 })
      expect(graph.render).to eq "xx\nxo\no"
    end
  end

end