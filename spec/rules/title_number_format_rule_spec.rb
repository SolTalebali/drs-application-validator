require_relative "../../lib/application"
require_relative "../../lib/rules/title_number_format_rule"

RSpec.describe TitleNumberFormatRule do
  it "returns nil when the title number is valid" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
     parties: ["Landlord", "Buyer"], fee_paid: 240, documents: ["TR1", "ID1", "ID2"])
    
    defect_report = TitleNumberFormatRule.new.check(application)
    expect(defect_report).to be_nil
  end

  it "return \"Invalid Title Number format\" when title number is invalid" do
    application = Application.new(title_number: "1234", transaction_type: "transfer",
     parties: ["Landlord", "Buyer"], fee_paid: 240, documents: ["TR1", "ID1", "ID2"])
    
    defect_report = TitleNumberFormatRule.new.check(application)
    expect(defect_report.reason).to eq("Invalid Title Number format.")
  end
end 
