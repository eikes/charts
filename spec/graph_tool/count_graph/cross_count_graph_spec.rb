require 'spec_helper'

RSpec.describe GraphTool::CrossCountGraph do
  include Capybara::RSpecMatchers
  let(:data) { { red: 1 } }
  let(:graph) { GraphTool::CrossCountGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }
  let(:columns) { 2 }
  let(:inner_margin) { 0 }
  let(:outer_margin) { 0 }
  let(:item_width) { 20 }
  let(:item_height) { 20 }
  let(:type) { :svg }
  let(:options) do
    {
      columns:      columns,
      item_width:   item_width,
      item_height:  item_height,
      inner_margin: inner_margin,
      outer_margin: outer_margin,
      type:         type
    }
  end
  let(:type) { :svg }

  describe 'setup' do
    it 'sets the SVG header' do
      expect(graph.render).to match(/DOCTYPE svg PUBLIC/)
    end
  end

  describe '#height and #width' do
    shared_examples 'has a width and height of' do |width, height|
      it "sets the svg root width to #{width}" do
        expect(svg.find('svg')[:width]).to eq(width.to_s)
      end
      it "sets the svg root height to #{height}" do
        expect(svg.find('svg')[:height]).to eq(height.to_s)
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
      let(:data) { { red: 2 } }
      let(:columns) { 1 }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two crosses' do
      let(:data) { { red: 2 } }
      include_examples 'has a width and height of', 40, 20
    end
  end

  describe 'root element' do
    it 'exists' do
      expect(svg).to have_css('svg')
    end
  end

  context 'one cross' do
    let(:data) { { '#FACADE' => 1 } }
    let(:item_width) { 100 }
    let(:line) { svg.all('line').first }
    it 'renders one cross with the correct color' do
      expect(line[:stroke]).to eq('#FACADE')
    end
    it 'renders a cross with a given width of 100 (item_width - 4)' do
      expect(line[:x2]).to eq('96')
    end
  end

  context 'two different crosses' do
    let(:data) { { red: 1, green: 1 } }
    let(:red_cross_left_top_right_bottom) { svg.all('line').first }
    let(:red_cross_left_bottom_right_top) { svg.all('line')[1] }
    let(:green_cross_left_top_right_bottom) { svg.all('line')[2] }
    let(:green_cross_left_bottom_right_top) { svg.all('line').last }
    let(:item_width) { 100 }
    let(:item_height) { 100 }

    it 'renders two crosses' do
      expect(svg.all('line').count).to eq(4)
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
      graph.render
    end
  end

  describe 'rmagick renderer' do
    let(:graph) { GraphTool::CrossCountGraph.new(data, options) }
    let(:data) { { red: 2 } }
    let(:item_width) { 100 }
    let(:item_height) { 100 }
    let(:type) { :png }

    it 'instantiates a Magick::ImageList object' do
      expect(Magick::ImageList).to receive(:new).and_return(Magick::ImageList.new)
      graph.render
    end

    it 'instantiates a Magick::Draw object' do
      expect(Magick::Draw).to receive(:new).and_return(Magick::Draw.new)
      graph.render
    end

    it 'calls #line on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:line).with(4, 4, 96, 96)
      expect_any_instance_of(Magick::Draw).to receive(:line).with(4, 96, 96, 4)
      expect_any_instance_of(Magick::Draw).to receive(:line).with(104, 4,  196, 96)
      expect_any_instance_of(Magick::Draw).to receive(:line).with(104, 96, 196, 4)
      graph.render
    end

    it 'calls #stroke on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:stroke).with('red').exactly(4).times
      graph.render
    end

    context 'filename is set' do
      let(:options) { { type: :png, filename: 'dots.jpg' } }
      it 'calls #write on the image' do
        expect_any_instance_of(Magick::ImageList).to receive(:write)
        graph.render
      end
    end
  end
end
