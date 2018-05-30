class List < ApplicationRecord
	belongs_to :user
	scope :search, -> (name) { where("name like ?", "#{name}%")}


end
