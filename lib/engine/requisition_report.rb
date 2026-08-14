class RequisitionReport
  attr_reader :defects

  def initialize(defects)
    @defects = defects
  end

  def clean?
    defects.empty?
  end
end