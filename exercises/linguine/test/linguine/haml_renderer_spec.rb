require_relative '../../lib/linguine/haml_renderer'
require 'haml'
require_relative '../../lib/linguine/exception'

describe HamlRenderer do

  subject(:renderer) { described_class.new('../../test') }

  describe '#render' do
    let(:expected_content) { {content: 'Some content'} }
    let(:expected_html) {
      "<!DOCTYPE html>\n<html>\n  <body>\n    <h2>#{expected_content[:content]}</h2>\n  </body>\n</html>\n"
    }

    it 'will render the html content for a valid view' do
      expect(subject.render('test_template', expected_content)).to eql(expected_html)
    end

    it 'will display an error for an invalid view' do
      error_msg = "Problem encountered whilst rendering view '../../test/resources/views/non_existing_template.haml'"
      expect { subject.render('non_existing_template', {}) }.to raise_error(HtmlRenderingException, error_msg)
    end
  end
end