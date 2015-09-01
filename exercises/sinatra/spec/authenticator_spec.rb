require 'authenticator'

describe Authenticator do

  subject(:authenticator) { described_class.new }

  let(:valid_username) { Authenticator::USERNAME }
  let(:valid_password) { Authenticator::PASSWORD }
  let(:invalid_username) { 'invalid_username' }
  let(:invalid_password) { 'invalid_password' }

  describe '#authenticator' do
    context 'the credentials will be accepted' do
      it 'will accept valid credentials' do
        expect(subject.authenticate(valid_username, valid_password)).to be_truthy
      end
    end

    context 'the credentials will be refused' do
      it 'will refuse an invalid username and password' do
        expect(subject.authenticate(invalid_username, invalid_password)).to be_falsey
      end

      it 'will refuse a valid username with an invalid password' do
        expect(subject.authenticate(valid_username, invalid_password)).to be_falsey
      end
    end
  end
end