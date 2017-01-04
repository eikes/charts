RSpec.describe 'bin/charts' do

  context 'script is loaded' do
    let(:script) do
      file_content = File.read('bin/charts')
      code = file_content.split("# code #")
      code[1]
    end
    context 'no args are provided' do
      let(:args) { [] }
      it 'prints the help message to stdout' do
        expect { eval script }.to output(/Usage: bin\/charts \[options\]/).to_stdout
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
    context 'bar graph one data set is provided' do
      let(:args) { ['--data', '10,20', '--style', 'bar'] }
      it 'prints the svg to stdout' do
        expect { eval script }.to output(/rect.*class="bar"/).to_stdout
      end
    end
    context 'bar graph two data sets are provided' do
      let(:args) { ['--data', '10,20', '--data', '20,30', '--style', 'bar'] }
      it 'prints the svg to stdout' do
        expect { eval script }.to output(/rect.*class="bar"/).to_stdout
      end
    end
    context 'README.md' do
      let(:readme_params) do
        readme = File.read('README.md')
        readme_examples = readme.scan(/bin\/charts ([^\n]*)/)
        readme_examples.map { |e| e.first.split(" ") }
      end
      before do
        # avoid writing to stdout
        allow($stdout).to receive(:puts)
        # avoid actually creating files
        allow_any_instance_of(Magick::ImageList).to receive(:write)
      end
      it 'executes all examples' do
        readme_params.each do |args|
          expect { eval script }.not_to raise_error
        end
      end
    end
  end

end
