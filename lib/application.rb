class Application
  attr_reader :title_number, :parties, :transaction_type, :fee_paid, :documents

  def initialize(title_number:, parties:, transaction_type:, fee_paid:, documents:)
    @title_number = title_number
    @parties = parties
    @transaction_type = transaction_type
    @fee_paid = fee_paid
    @documents = documents
  end
end