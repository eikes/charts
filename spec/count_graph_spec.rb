require 'spec_helper'
require 'count_graph'

RSpec.describe CountGraph do
  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { CountGraph.new(data, options) }

  describe '#initialize' do
    it 'provides default options' do
      graph = CountGraph.new(x: 2)
      expect(graph.options[:columns]).to eq(10)
    end
    it 'merges default options with passed in options' do
      graph = CountGraph.new({ x: 2 }, extra: 123)
      expect(graph.options[:columns]).to eq(10)
      expect(graph.options[:extra]).to eq(123)
    end
    it 'accepts numbers as strings' do
      expect { CountGraph.new(x: '2') }.to_not raise_error
    end
    it 'raises an error when value is not an Integer' do
      expect { CountGraph.new(x: '@$') }.to raise_error(ArgumentError)
    end
    it 'raises an error when a collection of values contains a Non-Integer' do
      expect { CountGraph.new(a: 12, x: '@$') }.to raise_error(ArgumentError)
    end
  end

  describe '#prepare_data' do
    it 'creates the prepared_data for simple keys' do
      graph = CountGraph.new({ x: 3, o: 2 }, columns: 2)
      expect(graph.prepared_data).to eq([
                                          %w(x x),
                                          %w(x o),
                                          ['o']
                                        ])
    end
    it 'creates the prepared_data for complex keys' do
      graph = CountGraph.new({ '#FF0000' => 2, '#00FF00' => 2 }, columns: 2)
      expect(graph.prepared_data).to eq([
                                          ['#FF0000', '#FF0000'],
                                          ['#00FF00', '#00FF00']
                                        ])
    end
  end

  describe '#default_options' do
    it 'has a default item width of 20' do
      expect(graph.options[:item_width]).to eq(20)
    end
    it 'has a default item height of 20' do
      expect(graph.options[:item_height]).to eq(20)
    end
    context 'with item_width 40 and item_height 40 in the options' do
      let(:options) { { item_width: 40, item_height: 40 } }
      it 'has the item_width in the options attribute' do
        expect(graph.options[:item_width]).to eq(40)
      end
      it 'has the item_height in the options attribute' do
        expect(graph.options[:item_height]).to eq(40)
      end
    end
  end

  describe '#height and #width' do
    it 'has a width attribute' do
      expect(graph).to respond_to(:width)
    end
    it 'has a height attribute' do
      expect(graph).to respond_to(:height)
    end
    shared_examples 'has a width and height of' do |width, height|
      it "sets the graph.width to #{width}" do
        expect(graph.width).to eq(width)
      end
      it "sets the graph.height to #{height}" do
        expect(graph.height).to eq(height)
      end
    end
    context 'one item' do
      let(:data) { { red: 1 } }
      let(:options) { { item_width: 20, item_height: 20 } }
      include_examples 'has a width and height of', 20, 20
    end
    context 'one item with different item width' do
      let(:data) { { red: 1 } }
      let(:options) { { item_width: 40, item_height: 40 } }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two items' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 1, item_width: 20, item_height: 20 } }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two items' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 2, item_width: 20, item_height: 20 } }
      include_examples 'has a width and height of', 40, 20
    end
  end

  context 'A child class has not implemented the required methods' do
    class BogusCountGraph < CountGraph
    end

    it 'raises an exception when draw_item is called' do
      expect { BogusCountGraph.new(x: 1).draw_item(1, 2, :red) }.to raise_error(NotImplementedError)
    end
  end
end
