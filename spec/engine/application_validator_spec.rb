require_relative "../../lib/application"
require_relative "../../lib/rules/fee_correct_rule"
require_relative "../../lib/rules/required_documents_rule"
require_relative "../../lib/rules/title_number_format_rule"
require_relative "../../lib/engine/application_validator"

RSpec.describe ApplicationValidator do
  FEES = {"transfer" => 270, "charge" => 40, "lease" => 90}
  DOCUMENTS = { "transfer" => ["TR1"], "charge" => ["CH1"], "lease" => ["Lease Deed"] }
  
  it "returns list of defects when passed a valid application." do
    fee_correct_rule = FeeCorrectRule.new(FEES)
    required_documents_rule = RequiredDocumentsRule.new(DOCUMENTS)
    title_number_format_rule = TitleNumberFormatRule.new

    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    results = ApplicationValidator.new([fee_correct_rule, required_documents_rule, title_number_format_rule]).validate(application)

    expect(results.length).to eq(0)
  end
end