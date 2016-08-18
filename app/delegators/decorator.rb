class DecoratorDelegator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def run
    decorate_class(model)
  end

  private

  def decorate_class(model)
    [model.class, 'decorator'].join('_').classify.constantize.new(model)
    rescue NameError
      model
  end
end
