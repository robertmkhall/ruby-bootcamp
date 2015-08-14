require 'rake'

shared_context :rake do

  let(:task_name) {}

  subject do
    app = Rake::Application.new.tap do |app|
      app.add_import("#{__dir__}/../../../lib/ruby_bootcamp/rake/#{self.class.top_level_description}")
      allow(Rake).to receive(:application).and_return(app)
      app.load_imports
    end
    app[task_name]
  end
end

describe 'tasks.rake' do
  include_context :rake

  let(:task_name) { 'tasks:list' }

  describe 'tasks:list' do

    context 'a valid file path is provided' do
      let(:test_dir) { 'random_dir/' }
      let(:expected_entries) { ['file1.jpg', 'some-other.txt', 'generic.doc', 'another.txt'] }
      let(:expected_txt_entries) { ['some-other.txt', 'another.txt'] }

      before do
        allow(Dir).to receive(:exists?).with(test_dir).and_return(true)
        allow(Dir).to receive(:glob).with(test_dir + '*').and_return(expected_entries)
        allow(Dir).to receive(:glob).with(test_dir + '.txt').and_return(expected_entries)
      end

      after do
        allow(Dir).to receive(:exists?).and_call_original
        allow(Dir).to receive(:glob).and_call_original
      end

      it 'outputs all the file names' do
        expected_output = format_expected_entries(expected_entries)

        expect { subject.invoke(test_dir) }.to output(expected_output).to_stdout
      end

      it 'outputs all the .txt file names' do
        expected_output = format_expected_entries(expected_txt_entries)

        expect { subject.invoke(test_dir, '.txt') }.to output(expected_output).to_stdout
      end

      def format_expected_entries(entries)
        expected_entries.inject('') { |result, entry| result += "#{entry}\n" }
      end
    end

    context 'an invalid path is provided' do
      it 'outputs an error' do
        expect { subject.invoke('invalid_path') }.to output("Path 'invalid_path' not found!\n").to_stdout
      end
    end
  end
end