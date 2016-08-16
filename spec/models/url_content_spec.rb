require 'spec_helper'

RSpec.describe UrlContent, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :header_one }
end
