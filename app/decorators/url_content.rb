class UrlContentDecorator
  extend Forwardable

  def_delegators :@model, :id, :name, :headers_one, :headers_two, :headers_three, :links

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    {
      id:    id,
      url:   name,
      h1:    headers_one,
      h2:    headers_two,
      h3:    headers_three,
      links: links
    }
  end
end
