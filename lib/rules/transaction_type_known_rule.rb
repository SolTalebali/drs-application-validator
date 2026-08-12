require_relative "../defect"

class TransactionTypeKnownRule
  TRANSACTION_TYPES = ["transfer", "charge", "lease"]

  def check(application)
    TRANSACTION_TYPES.include?(application.transaction_type) ? nil : Defect.new("Invalid transaction type.")
  end
end