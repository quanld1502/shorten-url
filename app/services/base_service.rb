class BaseService
  def self.execute(*args)
    new(*args).execute
  end

  def initialize(method, args = {})
    @method = method
    @args = args
  end

  def execute
    send(@method.to_sym)
  end
end
