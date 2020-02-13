class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.find_by(params)
    self.where(param).first
  end
end
