class List < ApplicationRecord
	belongs_to :user
	scope :search, -> (name) { where("name like ?", "#{name}%")}
	validates :name, presence: true
	validates :description, presence: true


end
