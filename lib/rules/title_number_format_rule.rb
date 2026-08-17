require_relative "../defect"

class TitleNumberFormatRule
  TITLE_NUMBER_FORMAT = /\A[A-Z]{1,3}\d{1,6}\z/

  def check(application)
    if application.title_number.nil?
      Defect.new("Invalid Title Number.")
    elsif application.title_number.match?(TITLE_NUMBER_FORMAT)
      nil
    else
      Defect.new("Invalid Title Number format.")
    end
  end
end