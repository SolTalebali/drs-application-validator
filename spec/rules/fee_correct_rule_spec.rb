require_relative "../../lib/application"
require_relative "../../lib/rules/fee_correct_rule"

RSpec.describe FeeCorrectRule do
  FEES = {"transfer" => 270, "charge" => 40, "lease" => 90}

  before do
    @rule = FeeCorrectRule.new(FEES)
  end
  
  it "returns nil when fee details are correct" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application)).to be_nil
  end

  it "flags incorrect fee details" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 230, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application).reason).to eq("Incorrect fee details.")
  end

  it "flags missing fee details" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}],
      documents: ["TR1", "ID1", "ID2"], fee_paid: nil)

      expect(@rule.check(application).reason).to eq("Missing fee details.")
  end
end