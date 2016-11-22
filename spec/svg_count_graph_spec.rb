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
    it 'renders two circles with the correct color' do
      expect(subject).to have_css('circle[cx="10"][cy="10"][fill="#FF0000"]')
      expect(subject).to have_css('circle[cx="30"][cy="10"][fill="#00FF00"]')
    end
  end
end
