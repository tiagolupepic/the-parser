class UrlContent < ActiveRecord::Base
  validates :name, presence: :true
end
