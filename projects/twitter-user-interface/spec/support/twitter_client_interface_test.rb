module TwitterClientInterfaceTest

  shared_examples_for 'twitter_client_interface' do
    it 'implements interface' do
      expect(subject).to respond_to(:home_timeline)
      expect(subject).to respond_to(:favourites)
      expect(subject).to respond_to(:direct_messages)
      expect(subject).to respond_to(:mentions)
      expect(subject).to respond_to(:retweet)
    end
  end
end