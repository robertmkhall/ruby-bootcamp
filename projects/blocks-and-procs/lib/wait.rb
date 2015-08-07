class Wait

  def self.until(retry_time, expire_after = 5)
    if block_given?
      started_execution = Time.now
      until yield || (Time.now.to_i - started_execution.to_i >= expire_after && (raise 'error'))
        sleep(retry_time)
      end
    end
  end
end