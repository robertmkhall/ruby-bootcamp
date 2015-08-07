require_relative '../lib/wait'
require 'timecop'

describe Wait do

  describe '.until' do

    it 'will repeat block until true' do
      cnt = 0

      Wait.until(0) { cnt +=1; cnt == 5 }

      expect(cnt).to equal(5)
    end

    it 'will wait 1 seconds between each attempt' do
      cnt = 0
      init_retry = Time.now
      start_retry = 0

      Timecop.scale(10)

      Wait.until(1) do
        start_retry = Time.now.to_i - init_retry.to_i
        cnt +=1
        init_retry = Time.now
        cnt == 2
      end

      expect(start_retry).to equal(10)
    end

    it 'will expire after 10 seconds' do

      Timecop.scale(10)
      start_time = Time.now

      expect{Wait.until(0, 10) {false}}.to raise_error(RuntimeError)
      expect(Time.now.to_i - start_time.to_i).to equal(10)
    end
  end
end