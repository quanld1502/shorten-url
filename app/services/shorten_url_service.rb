class ShortenUrlService < BaseService
  LENGTH = 6.freeze
  RETRY = 3.freeze

  def initialize(method, args = {})
    super

    @model = @args[:model] || Link
    @length = LENGTH
    @retries = RETRY
  end

  def shorten_url
    # the length of the code string is about 4/3 of @length.
    code = SecureRandom.base64(@length)

    while @model.exists?(slug: code)
      raise ActiveRecord::RecordNotUnique if @retries == 0

      @retries -= 1
      @length += rand(1..2)
    end

    code
  end
end