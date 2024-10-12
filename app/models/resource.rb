class Resource < ApplicationRecord
	belongs_to :category
	belongs_to :observation
	has_many :resource_datas
end
