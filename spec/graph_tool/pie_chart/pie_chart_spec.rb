RSpec.describe GraphTool::PieChart do
  let(:data) { [20, 40, 60, 80] }
  let(:options) do
    {
      type:         type,
      width:        width,
      height:       height,
      title:        title,
      labels:       labels,
      outer_margin: outer_margin
    }
  end
  let(:type) { :svg }
  let(:width) { 100 }
  let(:height) { 100 }
  let(:title) { nil }
  let(:labels) { [] }
  let(:outer_margin) { 0 }
  let(:graph) { GraphTool::PieChart.new(data, options) }
  let(:svg) { Nokogiri::XML(graph.render) }

  let(:paths) { svg.css('path') }

  describe '#initialize' do
    it 'provides default options' do
      expect(GraphTool::PieChart.new(data).width).to eq(600)
    end
    it 'provides default options' do
      expect(GraphTool::PieChart.new(data).height).to eq(400)
    end
  end

  describe '#prepare_data' do
    it 'prepares the sum' do
      expect(graph.sum).to eq(200)
    end
    it 'maps the data to a value between 0 and 1' do
      expect(graph.prepared_data).to eq([0.1, 0.2, 0.3, 0.4])
    end
    it 'prepares the sub sums' do
      sub_sums = graph.sub_sums.map {|v| v.round(1) }
      expect(sub_sums).to eq [0.0, 0.1, 0.3, 0.6, 1.0]
    end
    it 'maps the data to a value between 0 and 1' do
      graph.prepared_data.each do |value|
        expect(value).to be <= 1
        expect(value).to be >= 0
      end
    end
  end

  describe '#render' do
    let(:width) { 200 }
    let(:height) { 100 }
    let(:data) { [10, 10, 60] }
    it 'creates 3 slices' do
      expect(paths.count).to eq 3
    end
    it 'starts at the top' do
      expect(paths.first[:d]).to match /L100\.0 0\.0/
    end
    it 'each slice has a radius of 50' do
      paths.each do |path|
        expect(path[:d]).to match /A50 50/
      end
    end
    it 'starts and ends each slice in the center' do
      paths.each do |path|
        expect(path[:d]).to match /M100 50/
        expect(path[:d]).to match /L100 50/
      end
    end
  end

  describe '#draw_labels' do
    let(:labels) { ['One', 'Two', 'Three', 'Four'] }
    it 'creates 4 labels' do
      expect(svg.css('text.label').count).to eq 4
    end
  end


end
