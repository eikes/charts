require 'spec_helper'
require 'bitmap_circle_count_graph'
require 'capybara/rspec'

RSpec.describe BitmapCircleCountGraph do
  include Capybara::RSpecMatchers

  let(:data) { { red: 2, blue: 2 } }
  let(:options) { { columns: 2 } }
  let(:graph) { BitmapCircleCountGraph.new(data, options) }

  it 'instantiates a Magick::ImageList object' do
    expect(Magick::ImageList).to receive(:new).and_return(Magick::ImageList.new)
    graph.render
  end

  it 'instantiates a Magick::Draw object' do
    expect(Magick::Draw).to receive(:new).and_return(Magick::Draw.new)
    graph.render
  end

  it 'calls #circle on the canvas' do
    expect_any_instance_of(Magick::Draw).to receive(:circle).with(10, 10,  0, 10)
    expect_any_instance_of(Magick::Draw).to receive(:circle).with(30, 10, 20, 10)
    expect_any_instance_of(Magick::Draw).to receive(:circle).with(10, 30,  0, 30)
    expect_any_instance_of(Magick::Draw).to receive(:circle).with(30, 30, 20, 30)
    graph.render
  end

  it 'calls #fill on the canvas' do
    expect_any_instance_of(Magick::Draw).to receive(:fill).with('red').twice
    expect_any_instance_of(Magick::Draw).to receive(:fill).with('blue').twice
    graph.render
  end

  context 'filename is set' do
    let(:options) { { filename: 'dots.jpg' } }
    it 'calls #write on the image' do
      expect_any_instance_of(Magick::ImageList).to receive(:write)
      graph.render
    end
  end
end
