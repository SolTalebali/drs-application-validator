require_relative "../../lib/application"
require_relative "../../lib/rules/required_documents_rule"

RSpec.describe RequiredDocumentsRule do
  DOCUMENTS = { "transfer" => ["TR1"], "charge" => ["CH1"], "lease" => ["Lease Deed"] }

  before do
    @rule = RequiredDocumentsRule.new(DOCUMENTS)
  end

  it "returns nil when correct documents are passed" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application)).to be_nil
  end

  it "flags when some documents are missing" do
    application = Application.new(title_number: "AB1234", transaction_type: "charge",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    expect(@rule.check(application).reason).to eq("Missing required documents.")
  end

  it "flags when some documents are missing" do
    application = Application.new(title_number: "AB1234", transaction_type: "lease",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: [])

    expect(@rule.check(application).reason).to eq("Missing required documents.")
  end
end