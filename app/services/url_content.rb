class UrlContentService
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    return if name.blank?
  end
end
