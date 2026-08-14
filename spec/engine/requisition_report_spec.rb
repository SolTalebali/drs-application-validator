require_relative "../../lib/engine/requisition_report"
RSpec.describe RequisitionReport do
  it "returns true when passed an empty array" do
    expect(RequisitionReport.new([]).clean?).to eq(true)
  end

  it "returns false when passed an unempty array" do
    expect(RequisitionReport.new(["1", "2"]).clean?).to eq(false)
  end
end