require_relative "../defect"

class PartiesPresentRule
  def check(application)

    if application.parties.empty? 
      return Defect.new("Empty parties field.")
    elsif application.parties.any? {|name_field| 
    (name_field[:first_name].nil? || name_field[:first_name].strip.empty?)
    || (name_field[:last_name].nil? || name_field[:last_name].strip.empty?)
    || (name_field[:role].nil? || name_field[:role].strip.empty?)
    }
      return Defect.new("Missing party name field(s).")
    else
      return nil
    end
  end
end