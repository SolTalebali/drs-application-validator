require_relative "../defect"

class FeeCorrectRule
  def initialize(fees)
    @fees = fees
  end

  def check(application)
    if application.fee_paid.nil?
      Defect.new("Missing fee details.")
    elsif application.fee_paid != @fees[application.transaction_type]
      Defect.new("Incorrect fee details.")
    else
      nil
    end
  end
end