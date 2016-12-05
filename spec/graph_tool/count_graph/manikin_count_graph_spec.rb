require 'spec_helper'

RSpec.describe GraphTool::ManikinCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { [1] }
  let(:graph) { GraphTool::ManikinCountGraph.new(data, options) }
  let(:svg) { Capybara.string(graph.render) }
  let(:columns) { 2 }
  let(:item_width) { 20 }
  let(:item_height) { 20 }
  let(:type) { :svg }
  let(:colors) { 'green' }

  let(:options) do
    {
      columns:     columns,
      item_width:  item_width,
      item_height: item_height,
      type:        type,
      colors:      colors
    }
  end
  context 'one manikin' do
    let(:data) { [1] }
    let(:colors) { ['#FACADE'] }
    let(:item_width) { 100 }
    let(:item_height) { 100 }
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
    let(:data) { [1, 1] }
    let(:colors) { ['red', 'green'] }
    let(:item_width) { 100 }
    let(:item_height) { 100 }
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
    let(:data) { [1] }
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
      expect_any_instance_of(Magick::Draw).to receive(:stroke).with('#e41a1d').at_least(3).times
      graph.render
    end

    it 'calls #stroke on the canvas' do
      expect_any_instance_of(Magick::Draw).to receive(:fill).with('white').once
      expect_any_instance_of(Magick::Draw).to receive(:fill).with('#e41a1d').at_least(4).times
      graph.render
    end
  end
end
