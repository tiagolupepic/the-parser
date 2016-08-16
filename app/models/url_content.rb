class UrlContent < ActiveRecord::Base
  validates :name, :headers_one, presence: :true
end
