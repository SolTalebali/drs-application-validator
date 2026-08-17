require_relative "../application"
require_relative "requisition_report"

class ApplicationValidator
  def initialize(rules)
    @rules = rules
  end

  def validate(application)
    defects = @rules.map { |rule| rule.check(application) }.compact
    RequisitionReport.new(defects)
  end
end