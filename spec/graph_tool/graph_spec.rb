require 'spec_helper'

RSpec.describe GraphTool::Graph do
  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { GraphTool::Graph.new(data, options) }

  describe '#initialize' do
    it 'raises an error when no data is provided' do
      expect { GraphTool::Graph.new }.to raise_error(ArgumentError)
    end
    it 'calls the validate_arguments method' do
      expect_any_instance_of(GraphTool::Graph).to receive(:validate_data_arguments)
      GraphTool::Graph.new({})
    end
    it 'raises an error when the data hash is empty' do
      expect { GraphTool::Graph.new({}) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the options are not a hash' do
      expect { GraphTool::Graph.new({ x: 2 }, 'x') }.to raise_error(ArgumentError)
    end

    it 'stores the data in an instance attribute' do
      expect(graph.data).to eq(red: 1)
    end
    it 'stores the options in an instance attribute' do
      expect(graph.options).to include(columns: 2)
    end
  end

  describe '#prepare_data' do
    it 'calls the prepare_data method' do
      expect_any_instance_of(GraphTool::Graph).to receive(:prepare_data)
      GraphTool::Graph.new(x: 1)
    end
  end

  describe 'each option gets converted to an instance_method of the same name returning its value' do
    let(:options) do
      {
        columns:      5,
        colors:       ['#ABCDEF'],
        type:         'png',
        bogus_option: 123
      }
    end
    it 'has a columns method' do
      expect(graph.columns).to eq(5)
    end
    it 'has a colors method' do
      expect(graph.colors).to eq(['#ABCDEF'])
    end
    it 'has a type method' do
      expect(graph.type).to eq('png')
    end
    it 'has a bogus_option method' do
      expect(graph.bogus_option).to eq(123)
    end
  end

  context 'A child class has not implemented the required methods' do
    class GraphTool::BogusGraph < GraphTool::Graph
    end

    it 'raises an exception when pre_draw is called' do
      expect { GraphTool::BogusGraph.new(x: 1).pre_draw }.to raise_error(NotImplementedError)
    end

    it 'raises an exception when draw_item is called' do
      expect { GraphTool::BogusGraph.new(x: 1).draw }.to raise_error(NotImplementedError)
    end

    it 'raises an exception when post_draw is called' do
      expect { GraphTool::BogusGraph.new(x: 1).post_draw }.to raise_error(NotImplementedError)
    end
  end
end
