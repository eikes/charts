require 'spec_helper'
require 'count_graph'

RSpec.describe CountGraph do

  describe '#initialize' do
    it 'raises an error when no data is provided' do
      expect{ CountGraph.new }.to raise_error(ArgumentError)
    end
    it 'calls the validate_arguments method' do
      expect_any_instance_of(CountGraph).to receive(:validate_arguments)
      CountGraph.new({})
    end
    it 'raises an error when the data hash is empty' do
      expect{ CountGraph.new({}) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the data is not a hash' do
      expect{ CountGraph.new('x') }.to raise_error(ArgumentError)
    end
    it 'raises an error when the options are not a hash' do
      expect{ CountGraph.new({ x: 2 }, 'x') }.to raise_error(ArgumentError)
    end

    it 'stores the data in an instance attribute' do
      graph = CountGraph.new({ x: 2 })
      expect(graph.data).to eq({ x: 2 })
    end
    it 'stores the options in an instance attribute' do
      graph = CountGraph.new({ x: 2 }, { columns: 2 })
      expect(graph.options).to eq({ columns: 2})
    end
    it 'provides default options' do
      graph = CountGraph.new({ x: 2 })
      expect(graph.options[:columns]).to eq(10)
    end
    it 'merges default options with passed in options' do
      graph = CountGraph.new({ x: 2 }, { extra: 123 })
      expect(graph.options[:columns]).to eq(10)
      expect(graph.options[:extra]).to eq(123)
    end
    it 'accepts numbers as strings' do
      expect{ CountGraph.new({ x: "2" }) }.to_not raise_error(NoMethodError)
    end
    it 'raises an error when value is not an Integer' do
      expect{ CountGraph.new({ x: '@$' }) }.to raise_error(ArgumentError)
    end
    it 'raises an error when a collection of values contains a Non-Integer' do
      expect{ CountGraph.new({ a: 12, x: '@$' }) }.to raise_error(ArgumentError)
    end
  end

  describe '#prepare_data' do
    it 'calls the prepare_data method' do
      expect_any_instance_of(CountGraph).to receive(:prepare_data)
      CountGraph.new({x: 1})
    end
    it 'creates the prepared_data for simple keys' do
      graph = CountGraph.new({ x: 3, o: 2 }, { columns: 2 })
      expect(graph.prepared_data).to eq([
        ['x', 'x'],
        ['x', 'o'],
        ['o']
      ])
    end
    it 'creates the prepared_data for complex keys' do
      graph = CountGraph.new({ '#FF0000' => 2, '#00FF00' => 2 }, { columns: 2 })
      expect(graph.prepared_data).to eq([
        ['#FF0000', '#FF0000'],
        ['#00FF00', '#00FF00']
      ])
    end
  end
end
