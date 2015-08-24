RSpec::Matchers.define :have_columns do |*cols|
  match do |element|
    cols.each_index do |index|
      expect(element).to have_xpath("td[#{index+1}][text()='#{cols[index]}']")
    end
  end
end