require 'spec_helper'
require 'manikin_count_graph'
require 'capybara/rspec'

RSpec.describe ManikinCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 1 } }
  let(:options) { { columns: 2, type: :svg } }
  let(:graph) { ManikinCountGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }

  context 'one manikin' do
    let(:data) { { '#FACADE' => 1 } }
    let(:options) { { item_width: 100, item_height: 100 } }
    let(:head) { svg.find('circle') }
    let(:body) { svg.find('line.body') }
    let(:left_arm) { svg.find('line.left-arm') }
    let(:right_arm) { svg.find('line.right-arm') }

    it 'renders one manikin with the correct color' do
      expect(head[:fill]).to eq('#FACADE')
      expect(body[:stroke]).to eq('#FACADE')
      expect(left_arm[:stroke]).to eq('#FACADE')
      expect(right_arm[:stroke]).to eq('#FACADE')
    end
    it 'manikin-head and body are on the same vertical line' do
      expect(head[:cx]).to eq(body[:x1])
    end
    it 'manikin-body draws a vertical line' do
      expect(body[:x1]).to eq(body[:x2])
    end
  end

  context 'two manikins' do
    let(:data) { { red: 1, green: 1 } }
    let(:options) { { item_width: 100, item_height: 100 } }
    let(:red_head) { svg.all('circle').first }
    let(:green_head) { svg.all('circle').last }

    it 'renders the first manikin-head with the correct color' do
      expect(red_head[:fill]).to eq('red')
    end
    it 'renders the second manikin-head with the correct color' do
      expect(green_head[:fill]).to eq('green')
    end
    it 'renders heads of manikins on the same horizontal line' do
      expect(red_head[:cy]).to eq(green_head[:cy])
    end
  end

  describe 'rmagick renderer' do
    let(:data) { { red: 1 } }
    let(:options) { { type: :png } }

    it 'calls #circle on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:circle).exactly(1).times
      graph.render
    end

    it 'calls #line on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:line).exactly(3).times
      graph.render
    end

    it 'calls #stroke on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:stroke).with('red').at_least(3).times
      graph.render
    end

    it 'calls #stroke on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:fill).with('red').at_least(4).times
      graph.render
    end
  end

end
