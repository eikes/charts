require 'spec_helper'
require 'graph'

RSpec.describe Graph do
  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { Graph.new(data, options) }

  describe '#initialize' do
    it 'raises an error when no data is provided' do
      expect { Graph.new }.to raise_error(ArgumentError)
    end
    it 'calls the validate_arguments method' do
      expect_any_instance_of(Graph).to receive(:validate_arguments)
      Graph.new({})
    end
    it 'raises an error when the data hash is empty' do
      expect { Graph.new({}) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the data is not a hash' do
      expect { Graph.new('x') }.to raise_error(ArgumentError)
    end
    it 'raises an error when the options are not a hash' do
      expect { Graph.new({ x: 2 }, 'x') }.to raise_error(ArgumentError)
    end

    it 'stores the data in an instance attribute' do
      graph = Graph.new(x: 2)
      expect(graph.data).to eq(x: 2)
    end
    it 'stores the options in an instance attribute' do
      graph = Graph.new({ x: 2 }, columns: 2)
      expect(graph.options).to include(columns: 2)
    end
  end

  describe '#prepare_data' do
    it 'calls the prepare_data method' do
      expect_any_instance_of(Graph).to receive(:prepare_data)
      Graph.new(x: 1)
    end
  end

  context 'A child class has not implemented the required methods' do
    class BogusGraph < Graph
    end

    it 'raises an exception when pre_draw is called' do
      expect { BogusGraph.new(x: 1).pre_draw }.to raise_error(NotImplementedError)
    end

    it 'raises an exception when draw_item is called' do
      expect { BogusGraph.new(x: 1).draw }.to raise_error(NotImplementedError)
    end

    it 'raises an exception when post_draw is called' do
      expect { BogusGraph.new(x: 1).post_draw }.to raise_error(NotImplementedError)
    end
  end
end
