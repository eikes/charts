require 'spec_helper'

RSpec.describe 'bin/graph_tool' do

  context 'the important part of the script is loaded' do
    let(:script) do
      file_content = File.read('bin/graph_tool')
      code = file_content.split("# code #")
      code[1]
    end
    context 'no args are provided' do
      let(:args) { [] }
      it 'prints the help message to stdout' do
        expect { eval script }.to output(/Usage: bin\/graph_tool \[options\]/).to_stdout
      end
    end
    context 'data and colors args are provided' do
      let(:args) { ['--data', '1,1', '--colors', 'red,gold'] }
      it 'prints the svg to stdout' do
        expect { eval script }.to output(/DOCTYPE svg PUBLIC/).to_stdout
        expect { eval script }.to output(/red/).to_stdout
        expect { eval script }.to output(/gold/).to_stdout
        expect { eval script }.to output(/circle/).to_stdout
      end
    end
  end

end
