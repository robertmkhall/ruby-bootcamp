require_relative '../lib/authenticator'
require_relative 'spec_helper'

describe Authenticator do

  include_context :authentication

  subject(:authenticator) { described_class.new }

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