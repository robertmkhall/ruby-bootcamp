require_relative '../lib/authenticator'

describe Authenticator do

  subject(:authenticator) { described_class.new }

  describe '#authenticator' do
    let(:valid_username) { 'robertmkhall' }
    let(:valid_password) { 'password' }
    let(:invalid_username) { 'invalid_username' }
    let(:invalid_password) { 'invalid_password' }

    it 'will verify the credentials' do
      expect(subject.authenticate(valid_username, valid_password)).to be_truthy
    end

    context 'the credentials will be refused' do
      it 'an invalid username and invalid password will be refused' do
        expect(subject.authenticate(invalid_username, invalid_password)).to be_falsey
      end

      it 'an valid username but invalid password will be refused' do
        expect(subject.authenticate(valid_username, invalid_password)).to be_falsey
      end
    end
  end
end