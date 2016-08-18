class DecoratorDelegator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def run
    return decorate_collection   if collection?
    decorate_class(model)
  end

  private

  def decorate_collection
    model.map { |item| decorate_class(item) }
  end

  def decorate_class(item)
    [item.class, 'decorator'].join('_').classify.constantize.new(item)
    rescue NameError
      item
  end

  def collection?
    model.class.to_s =~ /ActiveRecord+\w+Relation\z/
  end
end
