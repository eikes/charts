RSpec.describe Charts::CountChart do
  let(:data) { [1] }
  let(:chart) { Charts::CountChart.new(data, options) }
  let(:columns) { 2 }
  let(:item_width) { 20 }
  let(:item_height) { 20 }
  let(:inner_margin) { 0 }
  let(:outer_margin) { 0 }
  let(:labels) { [] }
  let(:colors) { [] }
  let(:options) do
    {
      columns:      columns,
      item_width:   item_width,
      item_height:  item_height,
      inner_margin: inner_margin,
      outer_margin: outer_margin,
      colors:       colors,
      labels:       labels
    }
  end

  describe '#initialize' do
    it 'provides default options' do
      chart = Charts::CountChart.new([2])
      expect(chart.columns).to eq(10)
    end
    it 'merges default options with passed in options' do
      chart = Charts::CountChart.new([2], extra: 123)
      expect(chart.columns).to eq(10)
      expect(chart.extra).to eq(123)
    end
    it 'raises an error when value is not an Integer' do
      expect { Charts::CountChart.new(['k']) }.to raise_error(ArgumentError)
    end
    it 'raises an error when a collection of values contains a Non-Integer' do
      expect { Charts::CountChart.new([23, '@$']) }.to raise_error(ArgumentError)
    end
  end

  describe '#default_options' do
    let(:chart) { Charts::CountChart.new [1] }
    it 'has a default item-colors' do
      expect(chart.colors).to eq(
        [
          '#e41a1d',
          '#377eb9',
          '#4daf4b',
          '#984ea4',
          '#ff7f01',
          '#ffff34',
          '#a65629',
          '#f781c0',
          '#888888'
        ]
      )
    end
    it 'has a default background-colors' do
      expect(chart.background_color).to eq('white')
    end
    it 'has a default file-type' do
      expect(chart.type).to eq(:svg)
    end
    it 'has a default item width of 20' do
      expect(chart.item_width).to eq(20)
    end
    it 'has a default item height of 20' do
      expect(chart.item_height).to eq(20)
    end
    it 'has a default inner-margin of 2px' do
      expect(chart.inner_margin).to eq(2)
    end
    it 'has a default outer-margin of 30px' do
      expect(chart.outer_margin).to eq(30)
    end
    it 'has 10 default columns' do
      expect(chart.columns).to eq(10)
    end
    it 'has an empty labels attribute' do
      expect(chart.labels).to eq([])
    end
    context 'with item_width 40 and item_height 40 in the options' do
      let(:chart) { Charts::CountChart.new(data, options) }
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      it 'has the item_width in the options attribute' do
        expect(chart.item_width).to eq(40)
      end
      it 'has the item_height in the options attribute' do
        expect(chart.item_height).to eq(40)
      end
    end
  end

  describe '#background color' do
    it 'has a background_color attribute' do
      expect(chart).to respond_to(:background_color)
    end
  end

  describe '#draw labels' do
    it 'has a draw_labels attribute' do
      expect(chart).to respond_to(:draw_labels)
    end
  end

  describe '#draw label text' do
    it 'has a draw_label_text attribute' do
      expect(chart).to respond_to(:draw_label_text)
    end
  end

  describe '#label count' do
    it 'has a label_count attribute' do
      expect(chart).to respond_to(:label_count)
    end
  end

  describe 'inner margin' do
    it 'has a offset_x attribute' do
      expect(chart).to respond_to(:offset_x)
    end
    it 'has a offset_y attribute' do
      expect(chart).to respond_to(:offset_y)
    end
    it 'has a outer_item_width attribute' do
      expect(chart).to respond_to(:outer_item_width)
    end
    it 'has a outer_item_height attribute' do
      expect(chart).to respond_to(:outer_item_height)
    end
    it 'has a inner_margin attribute' do
      expect(chart).to respond_to(:inner_margin)
    end
    context 'width-margin of a single item' do
      let(:inner_margin) { 2 }
      it 'returns the correct outer_item_width' do
        expect(chart.outer_item_width).to eq(24)
      end
      it 'returns the correct offset_x' do
        expect(chart.offset_x(data.first)).to eq(24)
      end
    end
    context 'height-margin of a single item' do
      let(:item_height) { 20 }
      let(:inner_margin) { 2 }
      it 'returns the correct outer_item_height' do
        expect(chart.outer_item_height).to eq(24)
      end
      it 'returns the correct offset_y' do
        expect(chart.offset_y(data.first)).to eq(24)
      end
    end
    context 'width-margin of a several items' do
      let(:data) { [8] }
      let(:inner_margin) { 12 }
      it 'returns the correct outer_item_width' do
        expect(chart.outer_item_width).to eq(44)
      end
      it 'returns the correct offset_x' do
        expect(chart.offset_x(data.first)).to eq(352)
      end
    end
    context 'height-margin of a several items' do
      let(:data) { [8] }
      let(:item_height) { 40 }
      let(:inner_margin) { 12 }
      it 'returns the correct outer_item_height' do
        expect(chart.outer_item_height).to eq(64)
      end
      it 'returns the correct offset_y' do
        expect(chart.offset_y(data.first)).to eq(512)
      end
    end
  end

  describe '#prepare_data' do
    it 'creates the prepared_data for simple keys' do
      chart = Charts::CountChart.new([3, 2], colors: ['x', 'o'], columns: 2)
      expect(chart.prepared_data).to eq(
        [
          ['x', 'x'],
          ['x', 'o'],
          ['o']
        ]
      )
    end
    it 'creates the prepared_data for complex keys' do
      chart = Charts::CountChart.new([2, 2], colors: ['#FF0000', '#00FF00'], columns: 2)
      expect(chart.prepared_data).to eq(
        [
          ['#FF0000', '#FF0000'],
          ['#00FF00', '#00FF00']
        ]
      )
    end
    it 'default colors get assigned when no colors are specified' do
      chart = Charts::CountChart.new([1, 1, 1])
      expect(chart.prepared_data).to eq(
        [
          ['#e41a1d', '#377eb9', '#4daf4b']
        ]
      )
    end
  end

  shared_examples 'has a width and height of' do |width, height|
    it "sets the chart.width to #{width}" do
      expect(chart.width).to eq(width)
    end
    it "sets the chart.height to #{height}" do
      expect(chart.height).to eq(height)
    end
  end

  describe '#height and #width' do
    it 'has a width attribute' do
      expect(chart).to respond_to(:width)
    end
    it 'has a height attribute' do
      expect(chart).to respond_to(:height)
    end
    context 'one item' do
      include_examples 'has a width and height of', 20, 20
    end
    context 'one item with different item width' do
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two items' do
      let(:data) { [2] }
      let(:columns) { 1 }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two items' do
      let(:data) { [2] }
      include_examples 'has a width and height of', 40, 20
    end
  end

  describe '#height and #width with inner & outer margin' do
    context 'one item with inner margin' do
      let(:inner_margin) { 2 }
      include_examples 'has a width and height of', 24, 24
    end
    context 'two items with outer margin' do
      let(:data) { [2] }
      let(:outer_margin) { 20 }
      include_examples 'has a width and height of', 80, 60
    end
    context 'two items with inner- & outer margin' do
      let(:data) { [2] }
      let(:inner_margin) { 2 }
      let(:outer_margin) { 20 }
      include_examples 'has a width and height of', 88, 64
    end
  end

  describe '#height and #width with presence of labels' do
    context 'three items with three labels' do
      let(:data) { [3] }
      let(:labels) { ['Cars', 'Buses', 'Bikes'] }
      let(:item_height) { 20 }
      include_examples 'has a width and height of', 40, 120
    end
    context 'five items with five labels' do
      let(:data) { [5] }
      let(:labels) { ['Cars', 'Buses', 'Bikes', 'Planes', 'Ferries'] }
      let(:item_height) { 20 }
      include_examples 'has a width and height of', 40, 180
    end
    context 'five items in three columns with five labels' do
      let(:data) { [5] }
      let(:columns) { 3 }
      let(:labels) { ['Cars', 'Buses', 'Bikes', 'Planes', 'Ferries'] }
      let(:item_height) { 20 }
      include_examples 'has a width and height of', 60, 160
    end
  end

  describe '#item_height and #item_width' do
    it 'has a item width attribute' do
      expect(chart).to respond_to(:item_width)
    end
    it 'has a item height attribute' do
      expect(chart).to respond_to(:item_height)
    end
    context 'setup' do
      let(:data) { [2] }
      let(:item_width) { 50 }
      let(:item_height) { 50 }
      it 'item width gets correct value' do
        expect(chart.item_width).to eq(50)
      end
      it 'item height gets correct value' do
        expect(chart.item_height).to eq(50)
      end
    end
  end

  context 'A child class has not implemented the required methods' do
    class Charts::BogusCountChart < Charts::CountChart
    end

    it 'raises an exception when draw_item is called' do
      expect { Charts::BogusCountChart.new([1]).draw_item(1, 2, :red) }.to raise_error(NotImplementedError)
    end
  end
end
