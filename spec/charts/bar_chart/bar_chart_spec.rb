RSpec.describe Charts::BarChart do
  let(:data) { [[0, 10, 15, 20]] }
  let(:options) do
    {
      type:         type,
      width:        width,
      height:       height,
      group_margin: group_margin,
      title:        title,
      labels:       labels,
      group_labels: group_labels,
      bar_margin:   bar_margin,
      outer_margin: outer_margin,
      include_zero: include_zero
    }
  end
  let(:type) { :svg }
  let(:width) { 100 }
  let(:height) { 100 }
  let(:group_margin) { 0 }
  let(:title) { nil }
  let(:labels) { [] }
  let(:group_labels) { [] }
  let(:bar_margin) { 0 }
  let(:outer_margin) { 0 }
  let(:include_zero) { true }
  let(:chart) { Charts::BarChart.new(data, options) }
  let(:svg) { Nokogiri::XML(chart.render) }

  let(:rectangles) { svg.css('rect.bar') }
  let(:widths) { rectangles.map { |r| r[:width] } }
  let(:heights) { rectangles.map { |r| r[:height] } }
  let(:ys) { rectangles.map { |r| r[:y] } }
  let(:xs) { rectangles.map { |r| r[:x] } }

  describe '#initialize' do
    it 'provides default options' do
      expect(Charts::BarChart.new(data).width).to eq(600)
    end
    it 'provides default options' do
      expect(Charts::BarChart.new(data).height).to eq(400)
    end
  end

  describe '#prepare_data' do
    it 'maps the data to a value between 0 and 1' do
      expect(chart.prepared_data).to eq([[0, 0.5, 0.75, 1]])
    end
    it 'maps the data to a value between 0 and 1' do
      chart.prepared_data.each do |set|
        set.each do |item|
          expect(item).to be <= 1
          expect(item).to be >= 0
        end
      end
    end
    context 'data has negative values' do
      let(:data) { [[10, -10, 5, 0, -5]] }
      it 'maps the data to a value between 0 and 1' do
        expect(chart.prepared_data).to eq([[1.0, 0.0, 0.75, 0.5, 0.25]])
      end
      it 'sets the base_line' do
        expect(chart.base_line).to eq(0.5)
      end
    end
    context 'data has nil values' do
      let(:data) { [[0, nil, 20]] }
      it 'maps the data to a value between 0 and 1' do
        expect(chart.prepared_data).to eq([[0.0, nil, 1.0]])
      end
    end
    describe 'base_line' do
      context 'zero is 0' do
        let(:data) { [[0, 10]] }
        it 'sets the base_line' do
          expect(chart.base_line).to eq(0)
        end
      end
      context 'zero is 0.5' do
        let(:data) { [[-10, 10]] }
        it 'sets the base_line' do
          expect(chart.base_line).to eq(0.5)
        end
      end
      context 'zero is 1' do
        let(:data) { [[-10, 0]] }
        it 'sets the base_line' do
          expect(chart.base_line).to eq(1)
        end
      end
      context 'zero is 1' do
        let(:data) { [[10, 20]] }
        it 'sets the base_line' do
          expect(chart.base_line).to eq(0)
        end
      end
    end
  end

  describe '#initialize_instance_variables' do
    context 'data contains nil values' do
      let(:data) { [[10, nil, 20]] }
      let(:options) { { include_zero: false } }
      it 'sets max' do
        expect(chart.max_value).to eq(20)
      end
      it 'sets min' do
        expect(chart.min_value).to eq(10)
      end
    end
  end

  context 'one dataset with four bars' do
    let(:data) { [[0, 10, 15, 20]] }
    it 'renders four rect' do
      expect(rectangles.count).to eq(4)
    end
    it 'correctly sets the xs' do
      expect(xs).to eq(['0', '25', '50', '75'])
    end
    it 'correctly sets the width' do
      expect(widths).to eq(['25', '25', '25', '25'])
    end
    it 'correctly sets the ys' do
      expect(ys).to eq(['100.0', '50.0', '25.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['0.0', '50.0', '75.0', '100.0'])
    end
  end

  context 'one dataset with two bars, include_zero: true' do
    let(:data) { [[10, 20]] }
    let(:include_zero) { true }
    it 'correctly sets the ys' do
      expect(ys).to eq(['50.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['50.0', '100.0'])
    end
  end

  context 'one dataset with two bars, include_zero: false' do
    let(:data) { [[10, 20]] }
    let(:include_zero) { false }
    it 'correctly sets the ys' do
      expect(ys).to eq(['100.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['0.0', '100.0'])
    end
  end

  context 'min and max are set' do
    let(:data) { [[20, 40]] }
    let(:min_max_options) { options.merge(min: 10, max: 50) }
    let(:chart) { Charts::BarChart.new(data, min_max_options) }
    it 'correctly sets the ys' do
      expect(ys).to eq(['75.0', '25.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['25.0', '75.0'])
    end
  end

  context 'one dataset with four bars with negative values' do
    let(:data) { [[-10, 0, 10, 30]] }
    it 'renders three rect' do
      expect(rectangles.count).to eq(4)
    end
    it 'correctly sets the xs' do
      expect(xs).to eq(['0', '25', '50', '75'])
    end
    it 'correctly sets the width' do
      expect(widths).to eq(['25', '25', '25', '25'])
    end
    it 'correctly sets the ys' do
      expect(ys).to eq(['75.0', '75.0', '50.0', '0.0'])
    end
    it 'correctly sets the heights' do
      expect(heights).to eq(['25.0', '0.0', '25.0', '75.0'])
    end
  end

  context 'one dataset with two bars outer_margin: 10' do
    let(:data) { [[10, 20]] }
    let(:outer_margin) { 10 }
    it 'correctly sets the xs' do
      expect(xs).to eq(['10', '50'])
    end
    it 'correctly sets the widths' do
      expect(widths).to eq(['40', '40'])
    end
  end

  context 'one dataset with two bars bar_margin: 5' do
    let(:data) { [[10, 20]] }
    let(:bar_margin) { 5 }
    it 'correctly sets the xs' do
      expect(xs).to eq(['5', '55'])
    end
    it 'correctly sets the widths' do
      expect(widths).to eq(['40', '40'])
    end
  end

  context 'two dataset with two bars bar_margin: 0, group_margin: 10' do
    let(:data) { [[10, 20, 30, 40], [15, 25, 35, 45]] }
    let(:width) { 110 }
    let(:group_margin) { 10 }
    it 'correctly sets the xs' do
      expect(xs).to eq(['0', '30', '60', '90', '10', '40', '70', '100'])
    end
    it 'correctly sets the widths' do
      expect(widths).to eq(['10', '10', '10', '10', '10', '10', '10', '10'])
    end
  end

  describe '#height and #width' do
    it 'has a width attribute' do
      expect(chart).to respond_to(:width)
    end
    it 'has a height attribute' do
      expect(chart).to respond_to(:height)
    end
    context 'provides width and height via the options' do
      let(:options) { { width: 200, height: 200 } }
      it "sets the chart.width to 200" do
        expect(chart.width).to eq(200)
      end
      it "sets the chart.height to 200" do
        expect(chart.height).to eq(200)
      end
    end
  end

  describe 'option group_labels' do
    let(:group_labels) { ['one', 'two', 'three', 'four'] }
    it 'has text elements with the labels' do
      group_labels_texts = svg.css('text.group_label').map{ |t| t.text.tr("\n", '') }
      expect(group_labels_texts).to eq(group_labels)
    end
    describe 'too few group_labels' do
      let(:group_labels) { ['one', 'two'] }
      it 'raises an error' do
        expect{ chart.render }.to raise_error(ArgumentError, 'count of group-Labels and bars does not match')
      end
    end
  end

  describe 'option labels' do
    let(:data) { [[0, 10], [15, 20], [30, 10], [25, 35]] }
    let(:labels) { ['Alpha', 'Beta', 'Gamma', 'Delta'] }
    it 'has text elements with the labels' do
      labels_texts = svg.css('text.label').map{ |t| t.text.tr("\n", '') }
      expect(labels_texts).to eq(labels)
    end
    describe 'count of label and data does not match' do
      let(:labels) { ['Alpha', 'Beta'] }
      it 'raises an error' do
        expect{ chart.render }.to raise_error(ArgumentError, 'number of labels does not match array')
      end
    end
  end

  describe 'option title' do
    let(:title) { 'headline' }
    it 'has a title text element' do
      expect(svg.at_css('text.title').text.tr("\n", '')).to eq('headline')
    end
  end

  describe 'rmagick renderer' do
    let(:type) { :png }

    it 'calls #line on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:rectangle).exactly(5).times
      chart.render
    end
  end

end
