require "json"
require_relative "application"

class ApplicationLoader
  def self.load(path)
    parsed_data = JSON.parse(File.read(path), symbolize_names: true)
    Application.new(**parsed_data)
  end
end