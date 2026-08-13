require_relative "../defect"

class RequiredDocumentsRule
  def initialize(required_documents)
    @required_documents = required_documents
  end

  def check(application)
    if @required_documents[application.transaction_type].all?{|doc| application.documents.include?(doc)}
      nil
    else
      Defect.new("Missing required documents.")
    end
  end
end