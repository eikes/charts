require 'spec_helper'

RSpec.describe GraphTool::OptParser do
  let(:parser) { GraphTool::OptParser.new(args) }
  let(:parsed_options) { parser.parse }
  let(:data_args) { GraphTool::OptParser::DATA_EXAMPLE_ARGS.split(' ') }
  let(:color_args) { GraphTool::OptParser::COLOR_EXAMPLE_ARGS.split(' ') }
  context 'no arguments' do
    let(:args) { [] }
    it 'prints the help instructions' do
      expect($stdout).to receive(:puts)
      parsed_options
    end
  end
  context 'valid arguments' do
    let(:args) { data_args }
    it 'sets the data' do
      expect(parsed_options).to include(data: ['8', '7'])
    end
    it 'sets a default value for style' do
      expect(parsed_options).to include(style: :circle)
    end
    it 'sets a default value for type' do
      expect(parsed_options).to include(type: :svg)
    end
  end
  context 'no data is set' do
    let(:args) { ['--style', 'circle'] }
    it 'raises an error' do
      expect { parsed_options }.to raise_error(RuntimeError, "No data provided. Please pass in data using the --data flag: 'bin/graph_tool -d 8,7'")
    end
  end
  context 'a filename is set' do
    let(:args) { data_args + ['--filename', 'file.png'] }
    it 'sets type from the filename extension' do
      expect(parsed_options).to include(type: :png)
    end
  end
  context 'a filename is set with an unknown extension' do
    let(:args) { data_args + ['--filename', 'file.pdf'] }
    it 'raises an error' do
      expect { parsed_options }.to raise_error(RuntimeError, "No type provided. Set a type with --type flag or by setting a valid --filename")
    end
  end
  context 'type is set' do
    let(:args) { data_args + ['--type', 'png'] }
    it 'sets type' do
      expect(parsed_options).to include(type: :png)
    end
  end
  context 'columns are set' do
    let(:args) { data_args + ['--columns', '2'] }
    it 'sets columns' do
      expect(parsed_options).to include(columns: 2)
    end
  end
  context 'colors are set' do
    let(:args) { data_args + color_args }
    it 'sets columns' do
      expect(parsed_options).to include(colors: ['red', 'gold'])
    end
  end
  context 'item-width is set' do
    let(:args) { data_args + ['--item-width', '111'] }
    it 'sets item_width' do
      expect(parsed_options).to include(item_width: 111)
    end
  end
  context 'item-height is set' do
    let(:args) { data_args + ['--item-height', '222'] }
    it 'sets item_height' do
      expect(parsed_options).to include(item_height: 222)
    end
  end
end
