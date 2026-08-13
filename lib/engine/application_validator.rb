require_relative "../application"

class ApplicationValidator
  def initialize(rules)
    @rules = rules
  end

  def validate(application)
    @rules.map { |rule| rule.check(application) }.compact
  end
end