require 'spec_helper'

RSpec.describe GraphTool::Dispatcher do
  let(:graph) { dispatcher.graph }
  let(:dispatcher) { GraphTool::Dispatcher.new(options) }
  let(:options) { { data: data, type: type, style: style } }
  let(:data) { { red: 5, gold: 2 } }
  let(:type) { 'svg' }
  let(:style) { 'circle' }

  describe 'type txt' do
    let(:type) { 'txt' }
    it 'selects SymbolCountGraph' do
      expect(graph).to be_an_instance_of(GraphTool::SymbolCountGraph)
    end
  end

  describe 'style circle' do
    let(:style) { 'circle' }
    it 'selects CircleCountGraph' do
      expect(graph).to be_an_instance_of(GraphTool::CircleCountGraph)
    end
  end

  describe 'style cross' do
    let(:style) { 'cross' }
    it 'selects CrossCountGraph' do
      expect(graph).to be_an_instance_of(GraphTool::CrossCountGraph)
    end
  end

  describe 'style manikin' do
    let(:style) { 'manikin' }
    it 'selects ManikinCountGraph' do
      expect(graph).to be_an_instance_of(GraphTool::ManikinCountGraph)
    end
  end

  describe 'graph options' do
    let(:options) do
      {
        data:         data,
        style:        style,
        type:         type,
        filename:     filename,
        columns:      7,
        item_width:   111,
        item_height:  222,
        bogus_option: '123123'
      }
    end
    let(:filename) { 'some_file.png' }
    it 'sets the graph data' do
      expect(graph.data).to eq(data)
    end
    it 'sets the graph filename' do
      expect(graph.options).to include(filename: filename)
    end
    it 'sets the graph item_width' do
      expect(graph.options).to include(item_width: 111)
    end
    it 'sets the graph item_height' do
      expect(graph.options).to include(item_height: 222)
    end
    it 'sets the graph columns' do
      expect(graph.options).to include(columns: 7)
    end
    it 'does not set unknown options' do
      expect(graph.options).not_to include(bogus_option: '123123')
    end
  end
end
