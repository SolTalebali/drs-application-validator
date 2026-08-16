require_relative "../lib/application_loader"

RSpec.describe ApplicationLoader do
  it "loads a fixture correctly" do
    loaded_application = ApplicationLoader.load(File.join(__dir__, "fixture", "sample.json"))

    expect(loaded_application.title_number).to eq("1234")
    expect(loaded_application.documents).to eq([
    "TR1",
    "ID1",
    "ID2"
  ])
  end
end