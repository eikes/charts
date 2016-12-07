require 'spec_helper'

RSpec.describe GraphTool::SymbolCountGraph do
  let(:colors) { ['x'] }
  let(:options) do
    {
      colors:   colors,
      filename: filename
    }
  end
  shared_examples 'renders text' do |data, options, result|
    it "outputs #{result} when data = #{data} and options = #{options}" do
      graph = GraphTool::SymbolCountGraph.new(data, options)
      expect(graph.render).to eq result
    end
  end

  describe '#render' do
    include_examples 'renders text', [1], { colors: ['x'] }, 'x'
    include_examples 'renders text', [2], { colors: ['x'] }, 'xx'
    include_examples 'renders text', [3], { colors: ['x'], columns: 2 }, "xx\nx"
    include_examples 'renders text', [4], { colors: ['x'], columns: 3 }, "xxx\nx"
    include_examples 'renders text', [3, 2], { colors: ['x', 'o'], columns: 2 }, "xx\nxo\no"
    include_examples 'renders text', [1, 2], { colors: ['foto', 'otto'] }, 'foo'
  end

  context 'filename is set' do
    let(:data) { [1] }
    let(:filename) { 'dots.txt' }
    let(:graph) { GraphTool::SymbolCountGraph.new(data, options) }
    it 'calls File#open' do
      expect(File).to receive(:open)
      graph.render
    end
  end
end
