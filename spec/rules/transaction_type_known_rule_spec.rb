require_relative "../../lib/application"
require_relative "../../lib/rules/transaction_type_known_rule"

RSpec.describe TransactionTypeKnownRule do
  before do
    @rule = TransactionTypeKnownRule.new
  end
  it "returns nil when the transaction type is valid" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application)).to be_nil
  end

  it "returns nil when the transaction type is valid" do
    application = Application.new(title_number: "AB1234", transaction_type: "hello",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application).reason).to eq("Invalid transaction type.")
  end
end