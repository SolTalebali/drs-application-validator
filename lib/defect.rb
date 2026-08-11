class Defect
  attr_reader :reason

  def initialize(reason)
    @reason = reason
  end

  def ==(other)
    other.is_a?(Defect) && other.reason == reason
  end
end