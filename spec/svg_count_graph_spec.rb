require 'spec_helper'
require 'svg_count_graph'
require 'capybara/rspec'

RSpec.describe SvgCountGraph do
  include Capybara::RSpecMatchers
  
  let(:subject) { SvgCountGraph.new(data).render }

  context 'one circle' do
    let(:data) { { "#FF0000" => 1 } }
    it 'sets the SVG header' do
      expect(subject).to match /DOCTYPE svg PUBLIC/
      expect(subject).to match /svg width="100%" height="100%"/
    end
    it 'renders one circle with a radius of ten' do
      expect(subject).to have_css('circle[r="10"]')
    end
    it 'renders one circle with the correct color' do
      expect(subject).to have_css('circle[fill="#FF0000"]')
    end
  end
  context 'two different circles' do
    let(:data) { { "#FF0000" => 1, "#00FF00" => 1 } }
    # it 'renders two circles' do
    #   raise
    # end
    it 'renders two circles with the correct color' do
      expect(subject).to have_css('circle[cx="10"][cy="10"][fill="#FF0000"]')
      expect(subject).to have_css('circle[cx="30"][cy="10"][fill="#00FF00"]')
    end
  end
end
