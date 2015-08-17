require_relative '../../lib/linguine/haml_renderer'
require 'haml'
require_relative '../../lib/linguine/exception'

describe HamlRenderer do

  let(:view_path) { "#{__dir__}/.." }
  subject(:renderer) { described_class.new(view_path) }

  describe '#render' do
    let(:expected_content) { {content: 'Some content'} }
    let(:expected_html) {
      "<!DOCTYPE html>\n<html>\n  <body>\n    <h2>#{expected_content[:content]}</h2>\n  </body>\n</html>\n"
    }
    let(:non_existing_template) {'non_existing_template'}
    let(:expected_error) { "View file does not exist at '#{view_path}/resources/views/#{non_existing_template}.haml'" }

    it 'will render the html content for a valid view' do
      expect(subject.render('test_template', expected_content)).to eql(expected_html)
    end

    it 'will display an error for an invalid view' do
      expect { subject.render(non_existing_template, {}) }.to raise_error(HtmlRenderingException, expected_error)
    end
  end
end