require 'spec_helper'
require 'svg_count_graph'
require 'capybara/rspec'

RSpec.describe SvgCountGraph do
  include Capybara::RSpecMatchers
  let(:subject) { Capybara.string(SvgCountGraph.new(data).render) }

  describe 'general setup' do
    let(:data) { { red: 1 } }
    it 'sets the SVG header' do
      expect(SvgCountGraph.new(data).render).to match /DOCTYPE svg PUBLIC/
    end
    it 'sets the SVG root element' do
      expect(subject).to have_css('svg[width="100%"][height="100%"]')
    end
  end

  context 'one circle' do
    let(:data) { { "#FF0000" => 1 } }
    let(:circle) { subject.find('circle') }
    it 'renders one circle with a radius of ten' do
      expect(circle[:r]).to eq('10')
    end
    it 'renders one circle with the correct color' do
      expect(circle[:fill]).to eq('#FF0000')
    end
  end

  context 'two different circles' do
    let(:data) { { "#FF0000" => 1, "#00FF00" => 1 } }
    let(:red_circle) { subject.all('circle').first }
    let(:green_circle) { subject.all('circle').last }
    it 'renders two circles' do
      expect(subject.all('circle').count).to eq(2)
    end
    it 'renders one red circle' do
      expect(red_circle[:fill]).to eq("#FF0000")
    end
    it 'renders the red circle on the left' do
      expect(red_circle[:cx]).to eq("10")
    end
    it 'renders the red circle on the top' do
      expect(red_circle[:cy]).to eq("10")
    end

    it 'renders one green circle' do
      expect(green_circle[:fill]).to eq("#00FF00")
    end
    it 'renders the green circle on the left' do
      expect(green_circle[:cx]).to eq("30")
    end
    it 'renders the green circle on the top' do
      expect(green_circle[:cy]).to eq("10")
    end
  end
end
