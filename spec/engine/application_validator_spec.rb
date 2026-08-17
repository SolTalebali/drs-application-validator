require_relative "../../lib/application"
require_relative "../../lib/rules/fee_correct_rule"
require_relative "../../lib/rules/required_documents_rule"
require_relative "../../lib/rules/title_number_format_rule"
require_relative "../../lib/engine/application_validator"

RSpec.describe ApplicationValidator do
  before do
    @fee_correct_rule = FeeCorrectRule.new({"transfer" => 270, "charge" => 40, "lease" => 90})
    @required_documents_rule = RequiredDocumentsRule.new({ "transfer" => ["TR1"], "charge" => ["CH1"], "lease" => ["Lease Deed"] })
    @title_number_format_rule = TitleNumberFormatRule.new
  end

  it "returns an empty list of defects when passed a valid application." do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    report = ApplicationValidator.new([@fee_correct_rule, @required_documents_rule, @title_number_format_rule]).validate(application)

    expect(report.clean?).to eq(true)
  end

  it "returns a list of defects when passed faulty application." do
    application = Application.new(title_number: "1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 220, documents: ["", "ID1", "ID2"])

    results = ApplicationValidator.new([@fee_correct_rule, @required_documents_rule, @title_number_format_rule]).validate(application)

    expect(results.defects.length).to eq(3)
  end

  it "returns two specific defects for two defects in the application." do
    application = Application.new(title_number: "AB1234", transaction_type: "charge",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 270, documents: ["TR1", "ID1", "ID2"])

    results = ApplicationValidator.new([@fee_correct_rule, @required_documents_rule, @title_number_format_rule]).validate(application)

    expect(results.defects.length).to eq(2)
    expect(results.defects[0].reason).to eq("Incorrect fee details.")
    expect(results.defects[1].reason).to eq("Missing required documents.")
  end
end