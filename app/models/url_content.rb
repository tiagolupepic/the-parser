class UrlContent < ActiveRecord::Base
  validates :name, :header_one, presence: :true
end
