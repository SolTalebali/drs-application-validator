require_relative "../../lib/application"
require_relative "../../lib/rules/parties_present_rule"

RSpec.describe PartiesPresentRule do
  it "returns nil when name fields are valid" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 240, documents: ["TR1", "ID1", "ID2"])
  
    defect_report = PartiesPresentRule.new.check(application)
    expect(defect_report).to be_nil
  end

  it "flags if there are any invalid name fields" do
    application = Application.new(title_number: "AB1234", transaction_type: "transfer",
      parties: [{first_name: "Jon", last_name: "Jones", role: "Buyer"},{first_name: "", last_name: "McGregor", role: "Landlord"}], 
      fee_paid: 240, documents: ["TR1", "ID1", "ID2"])

    defect_report = PartiesPresentRule.new.check(application)
    expect(defect_report.reason).to eq("Missing party name field(s).")
  end

  it "flags if there are any invalid name fields" do
  application = Application.new(title_number: "AB1234", transaction_type: "transfer",
    parties: [{first_name: "Jon", role: "Buyer"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
    fee_paid: 240, documents: ["TR1", "ID1", "ID2"])

  defect_report = PartiesPresentRule.new.check(application)
  expect(defect_report.reason).to eq("Missing party name field(s).")
  end

  it "flags if there are any invalid name fields" do
  application = Application.new(title_number: "AB1234", transaction_type: "transfer",
    parties: [{first_name: "Jon", last_name: "Jones"},{first_name: "Conor", last_name: "McGregor", role: "Landlord"}], 
    fee_paid: 240, documents: ["TR1", "ID1", "ID2"])

  defect_report = PartiesPresentRule.new.check(application)
  expect(defect_report.reason).to eq("Missing party name field(s).")
  end
end