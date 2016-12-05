require 'spec_helper'

RSpec.describe GraphTool::OptParser do
  let(:parser) { GraphTool::OptParser.new(args) }
  let(:parsed_options) { parser.parse }
  let(:data) { ['--data', 'red:5,gold:2'] }
  describe 'valid arguments' do
    let(:args) { data }
    it 'sets the data' do
      expect(parsed_options).to include(data: {'red' => '5', 'gold' => '2'})
    end
    it 'sets a default value for style' do
      expect(parsed_options).to include(style: :circle)
    end
    it 'sets a default value for type' do
      expect(parsed_options).to include(type: :svg)
    end
  end
  describe 'a filename is set' do
    let(:args) { data + ['--filename', 'file.png'] }
    it 'sets type from the filename extension' do
      expect(parsed_options).to include(type: :png)
    end
  end
end
