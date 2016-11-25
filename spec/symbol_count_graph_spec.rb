require 'spec_helper'
require 'symbol_count_graph'

RSpec.describe SymbolCountGraph do

  shared_examples 'renders text' do |data, options, result|
    it "outputs #{result.gsub("\n", "\\n")} when data = #{data} and options = #{options}" do
      graph = SymbolCountGraph.new(data, options)
      expect(graph.render).to eq result
    end
  end

  describe '#render' do
    include_examples 'renders text', { x: 1 }, {}, 'x'
    include_examples 'renders text', { x: 2 }, {}, 'xx'
    include_examples 'renders text', { x: 3 }, { columns: 2 }, "xx\nx"
    include_examples 'renders text', { x: 4 }, { columns: 3 }, "xxx\nx"
    include_examples 'renders text', { x: 3, o: 2 }, { columns: 2 }, "xx\nxo\no"
    include_examples 'renders text', { foto: 1, otto: 2 }, {}, 'foo' # renders the first letter of the key only
  end

  context 'filename is set' do
    let(:data) { { x: 1 } }
    let(:options) { { filename: 'dots.txt' } }
    let(:graph) { SymbolCountGraph.new(data, options) }
    it 'calls File#open' do
      expect(File).to receive(:open)
      graph.render
    end
  end

end
