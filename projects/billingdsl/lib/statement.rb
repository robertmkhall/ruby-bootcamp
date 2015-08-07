class Statement

  attr_accessor :date, :due

  # attr_reader :attributes

  def initialize(&block)
    @attributes = {}

    instance_eval &block
  end

  def method_missing(name, *args, &block)
    attributes[name] = args[0]
  end

  # alias_method :date, :date=
  alias_method :due, :due=
end