RSpec.describe Charts::Chart do
  let(:data) { [1] }
  let(:options) { { columns: 2, colors: ['red']} }
  let(:graph) { Charts::Chart.new(data, options) }

  describe '#initialize' do
    it 'raises an error when no data is provided' do
      expect { Charts::Chart.new }.to raise_error(ArgumentError)
    end
    it 'calls the validate_arguments method' do
      expect_any_instance_of(Charts::Chart).to receive(:validate_arguments)
      Charts::Chart.new({})
    end
    it 'raises an error when the data array is empty' do
      expect { Charts::Chart.new([]) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the options are not a hash' do
      expect { Charts::Chart.new([2], 'x') }.to raise_error(ArgumentError)
    end
    it 'raises an error when the data is not an array' do
      expect { Charts::Chart.new('', {}) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the colors are not an array' do
      expect { Charts::Chart.new([2], colors: 'red') }.to raise_error(ArgumentError)
    end
    it 'raises an error when there are less colors then data item' do
      expect { Charts::Chart.new([2, 4], colors: ['red']) }.to raise_error(ArgumentError)
    end
    it 'raises an error when the labels are not an array' do
      expect { Charts::Chart.new([2], labels: 'red') }.to raise_error(ArgumentError)
    end
    it 'raises an error when there are less labels then data item' do
      expect { Charts::Chart.new([2, 4], labels: ['red']) }.to raise_error(ArgumentError)
    end
    it 'stores the data in an instance attribute' do
      expect(graph.data).to eq([1])
    end
    it 'stores the options in an instance attribute' do
      expect(graph.options).to include(columns: 2)
    end
  end

  describe '#prepare_data' do
    it 'calls the prepare_data method' do
      expect_any_instance_of(Charts::Chart).to receive(:prepare_data)
      Charts::Chart.new([1])
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
    class Charts::BogusChart < Charts::Chart
    end

    it 'raises an exception when draw_item is called' do
      expect { Charts::BogusChart.new([1]).draw }.to raise_error(NotImplementedError)
    end
  end
end
