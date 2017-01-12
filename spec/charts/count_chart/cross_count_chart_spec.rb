RSpec.describe Charts::CrossCountChart do
  let(:data) { [1] }
  let(:chart) { Charts::CrossCountChart.new(data, options) }
  let(:svg) { Nokogiri::XML(chart.render) }
  let(:columns) { 2 }
  let(:inner_margin) { 0 }
  let(:outer_margin) { 0 }
  let(:item_width) { 20 }
  let(:item_height) { 20 }
  let(:type) { :svg }
  let(:colors) { ['green'] }
  let(:options) do
    {
      columns:      columns,
      item_width:   item_width,
      item_height:  item_height,
      inner_margin: inner_margin,
      outer_margin: outer_margin,
      type:         type,
      colors:       colors
    }
  end
  let(:type) { :svg }

  describe 'setup' do
    it 'sets the SVG header' do
      expect(chart.render).to match(/DOCTYPE svg PUBLIC/)
    end
  end

  describe '#height and #width' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.at_css('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.at_css('svg')[:height]).to eq(height.to_s)
      end
    end
    context 'one cross' do
      include_examples 'has a width and height of', 20, 20
    end
    context 'one cross with a different width' do
      let(:item_width) { 40 }
      let(:item_height) { 40 }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two crosses' do
      let(:data) { [2] }
      let(:colors) { ['red'] }
      let(:columns) { 1 }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two crosses' do
      let(:data) { [2] }
      let(:colors) { ['red'] }
      include_examples 'has a width and height of', 40, 20
    end
  end

  context 'one cross' do
    let(:data) { [1] }
    let(:colors) { ['#FACADE'] }
    let(:item_width) { 100 }
    let(:line) { svg.css('line').first }
    it 'renders one cross with the correct color' do
      expect(line[:stroke]).to eq('#FACADE')
    end
    it 'renders a cross with a given width of 100 (item_width - 4)' do
      expect(line[:x2]).to eq('96')
    end
  end

  context 'two different crosses' do
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:red_cross_left_top_right_bottom) { svg.css('line').first }
    let(:red_cross_left_bottom_right_top) { svg.css('line')[1] }
    let(:green_cross_left_top_right_bottom) { svg.css('line')[2] }
    let(:green_cross_left_bottom_right_top) { svg.css('line').last }
    let(:item_width) { 100 }
    let(:item_height) { 100 }

    it 'renders two crosses' do
      expect(svg.css('line').count).to eq(4)
    end
    context 'red cross' do
      it 'renders one red cross' do
        expect(red_cross_left_top_right_bottom[:stroke]).to eq('red')
      end
      context 'left, top, right, bottom' do
        it 'renders the red cross x1' do
          expect(red_cross_left_top_right_bottom[:x1]).to eq('4')
        end
        it 'renders the red cross y1' do
          expect(red_cross_left_top_right_bottom[:y1]).to eq('4')
        end
        it 'renders the red cross x2' do
          expect(red_cross_left_top_right_bottom[:x2]).to eq('96')
        end
        it 'renders the red cross y2' do
          expect(red_cross_left_top_right_bottom[:y2]).to eq('96')
        end
      end

      context 'left, bottom, right, top' do
        it 'renders the red cross x1' do
          expect(red_cross_left_bottom_right_top[:x1]).to eq('4')
        end
        it 'renders the red cross y1' do
          expect(red_cross_left_bottom_right_top[:y1]).to eq('96')
        end
        it 'renders the red cross x2' do
          expect(red_cross_left_bottom_right_top[:x2]).to eq('96')
        end
        it 'renders the red cross y2' do
          expect(red_cross_left_bottom_right_top[:y2]).to eq('4')
        end
      end
    end

    context 'green cross' do
      it 'renders one green cross' do
        expect(green_cross_left_top_right_bottom[:stroke]).to eq('green')
      end
      context 'left, top, right, bottom' do
        it 'renders the red cross x1' do
          expect(green_cross_left_top_right_bottom[:x1]).to eq('104')
        end
        it 'renders the red cross y1' do
          expect(green_cross_left_top_right_bottom[:y1]).to eq('4')
        end
        it 'renders the red cross x2' do
          expect(green_cross_left_top_right_bottom[:x2]).to eq('196')
        end
        it 'renders the red cross y2' do
          expect(green_cross_left_top_right_bottom[:y2]).to eq('96')
        end
      end
      context 'left, bottom, right, top' do
        it 'renders the red cross x1' do
          expect(green_cross_left_bottom_right_top[:x1]).to eq('104')
        end
        it 'renders the red cross y1' do
          expect(green_cross_left_bottom_right_top[:y1]).to eq('96')
        end
        it 'renders the red cross x2' do
          expect(green_cross_left_bottom_right_top[:x2]).to eq('196')
        end
        it 'renders the red cross y2' do
          expect(green_cross_left_bottom_right_top[:y2]).to eq('4')
        end
      end
    end
  end

  context 'filename is set' do
    let(:options) { { filename: 'dots.svg' } }
    it 'calls #save on the SVG' do
      expect_any_instance_of(SVG).to receive(:save)
      chart.render
    end
  end
end
