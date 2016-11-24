require 'spec_helper'
require 'svg_circle_count_graph'
require 'capybara/rspec'

RSpec.describe SvgCircleCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 1 } }
  let(:options) { { columns: 2 } }
  let(:graph) { SvgCircleCountGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }

  describe 'setup' do
    it 'sets the SVG header' do
      expect(graph.render).to match(/DOCTYPE svg PUBLIC/)
    end
    it 'has a default radius' do
      expect(graph.options[:radius]).to eq(10)
    end
    context 'with radius 20 in the options' do
      let(:options) { { radius: 20 } }
      it 'has the radius in the options attribute' do
        expect(graph.options[:radius]).to eq(20)
      end
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
    context 'one circle' do
      let(:data) { { red: 1 } }
      include_examples 'has a width and height of', 20, 20
    end
    context 'one circle with a differen radius' do
      let(:data) { { red: 1 } }
      let(:options) { { radius: 20 } }
      include_examples 'has a width and height of', 40, 40
    end
    context 'one column two circles' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 1 } }
      include_examples 'has a width and height of', 20, 40
    end
    context 'two columns two circles' do
      let(:data) { { red: 2 } }
      let(:options) { { columns: 2 } }
      include_examples 'has a width and height of', 40, 20
    end
  end

  describe 'root element' do
    it 'exists' do
      expect(svg).to have_css('svg')
    end
  end

  context 'one circle' do
    let(:data) { { "#FACADE" => 1 } }
    let(:circle) { svg.find('circle') }
    it 'renders one circle with a default radius of ten' do
      expect(circle[:r]).to eq('10')
    end
    it 'renders one circle with the correct color' do
      expect(circle[:fill]).to eq('#FACADE')
    end
  end
  context 'radius' do
    let(:data) { { "#FACADE" => 1 } }
    let(:options) { { radius: 100 } }
    let(:circle) { svg.find('circle') }
    it 'renders a circle with a given radius of hundred' do
      expect(circle[:r]).to eq('100')
    end
  end

  context 'two different circles' do
    let(:data) { { red: 1, green: 1 } }
    let(:red_circle) { svg.all('circle').first }
    let(:green_circle) { svg.all('circle').last }
    it 'renders two circles' do
      expect(svg.all('circle').count).to eq(2)
    end
    it 'renders one red circle' do
      expect(red_circle[:fill]).to eq("red")
    end
    it 'renders the red circle on the left' do
      expect(red_circle[:cx]).to eq("10")
    end
    it 'renders the red circle on the top' do
      expect(red_circle[:cy]).to eq("10")
    end

    it 'renders one green circle' do
      expect(green_circle[:fill]).to eq("green")
    end
    it 'renders the green circle on the left' do
      expect(green_circle[:cx]).to eq("30")
    end
    it 'renders the green circle on the top' do
      expect(green_circle[:cy]).to eq("10")
    end
  end

end