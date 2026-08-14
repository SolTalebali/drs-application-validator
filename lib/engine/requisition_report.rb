RequisitionReport = Struct.new(:defects) do
  def clean?
    defects.empty?
  end
end